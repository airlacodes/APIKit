//
//  RequestSender.swift
//  APIKit
//
//  Created by Codeonomics on 16/06/2019.
//  Copyright © 2019 Codeonomics.io All rights reserved.
//

import Foundation

protocol RequestSender {
    func request(endpoint: Endpoint,
                 callback: @escaping (NetworkResult) -> Void)
    func cancelNetworkRequest()
}

class HTTPRequestSender: RequestSender {

    private let urlSession: URLSession
    private let responseHandler: ResponseHandler
    
    init(urlSession: URLSession = URLSession.shared,
         responseHandler: ResponseHandler = APIKitResponseHandler()) {
        self.urlSession = urlSession
        self.responseHandler = responseHandler
    }

    func request(endpoint: Endpoint, callback: @escaping (NetworkResult) -> Void) {
        var request = URLRequest(url: URL(string: endpoint.path)!)
        
        APIKit.requestInterceptor?.sendWithHeaders(endpoint: endpoint).forEach { header in
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        let task = urlSession.dataTask(with: request,
                                       completionHandler: { (data, response, error) in
                                        if let error = error {
                                            callback(.failure(error))
                                        } else if let data = data {
                                            self.responseHandler.handle(response: response,
                                                                   data: data,
                                                                   completion: callback)
                                        } else {
                                            callback(.failure(APIError.unexpectedError))
                                        }
        })
        task.resume()
    }

    func cancelNetworkRequest() {

    }
}

class BearerRequestSender: RequestSender {
    
    private let urlSession: URLSession
    private let credentialsStore: CredentialsStore
    private let tokenRefresher: TokenRefresher
    private let responseHandler: ResponseHandler
    
    init(urlSession: URLSession = URLSession.shared,
         credentialsStore: CredentialsStore = APIKitCredentialsStore(),
         tokenRefresher: TokenRefresher = APIKitTokenRefresher(),
         responseHandler: ResponseHandler = APIKitResponseHandler()) {
        self.urlSession = urlSession
        self.credentialsStore = credentialsStore
        self.tokenRefresher = tokenRefresher
        self.responseHandler = responseHandler
    }
    
    func request(endpoint: Endpoint, callback: @escaping (NetworkResult) -> Void) {

        if(tokenRefresher.credentialsStore.shouldRefreshCredentials()) {
            tokenRefresher.refresh(completion: { result in
                switch result {
                case .refreshed:
                    self.completeRequest(endpoint: endpoint, callback: callback)
                case .refreshFailed:
                    callback(.failure(APIError.unexpectedError))
                case .shouldRetry:
                    callback(.failure(APIError.unauthorised))
                }
            })
        } else {
            completeRequest(endpoint: endpoint, callback: callback)
        }

    }
    
    private func completeRequest(endpoint: Endpoint, callback: @escaping (NetworkResult) -> Void) {
        var request = URLRequest(url: URL(string: endpoint.path)!)
        
        guard let bearer = tokenRefresher.credentialsStore.getCurrentCredentials()?.accessToken else {
            callback(.failure(APIError.unauthorised))
            return
        }
        
        request.addValue("Bearer \(bearer)", forHTTPHeaderField: "Authorization")
        
        APIKit.requestInterceptor?.sendWithHeaders(endpoint: endpoint).forEach { header in
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        let task = urlSession.dataTask(with: request,
                                       completionHandler: { [weak self](data, response, error) in
                                        if let error = error {
                                            callback(.failure(error))
                                        } else if let data = data {
                                            self?.responseHandler.handle(response: response,
                                                                   data: data,
                                                                   completion: callback)
                                            callback(.success(data))
                                        } else {
                                            callback(.failure(APIError.unexpectedError))
                                        }
        })
        task.resume()
    }
    func cancelNetworkRequest() {
        
    }
    
    
}


struct APIKitVoid: APIModel {}
