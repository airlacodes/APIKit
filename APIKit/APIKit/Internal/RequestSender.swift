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

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    func request(endpoint: Endpoint, callback: @escaping (NetworkResult) -> Void) {
        let request = URLRequest(url: URL(string: endpoint.path)!)
        let task = urlSession.dataTask(with: request,
                                       completionHandler: { (data, response, error) in
                                        if let error = error {
                                            callback(.failure(error))
                                        } else if let data = data {
                                            callback(.success(data))
                                        } else {
                                            callback(.failure(APIError.networokingError))
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
    
    init(urlSession: URLSession = URLSession.shared,
         credentialsStore: CredentialsStore = APIKitCredentialsStore(),
         tokenRefresher: TokenRefresher = APIKitTokenRefresher()) {
        self.urlSession = urlSession
        self.credentialsStore = credentialsStore
        self.tokenRefresher = tokenRefresher
    }
    
    func request(endpoint: Endpoint, callback: @escaping (NetworkResult) -> Void) {

        if(tokenRefresher.credentialsStore.shouldRefreshCredentials()) {
            tokenRefresher.refresh(completion: { [weak self] result in
                switch result {
                case .refreshed:
                    self?.completeRequest(endpoint: endpoint, callback: callback)
                case .refreshFailed:
                    callback(.failure(APIError.networokingError))
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
        
        request.addValue(bearer, forHTTPHeaderField: "Bearer")
        let task = urlSession.dataTask(with: request,
                                       completionHandler: { (data, response, error) in
                                        if let error = error {
                                            callback(.failure(error))
                                        } else if let data = data {
                                            callback(.success(data))
                                        } else {
                                            callback(.failure(APIError.networokingError))
                                        }
        })
        task.resume()
    }
    func cancelNetworkRequest() {
        
    }
    
    
}


struct APIKitVoid: APIModel {}
