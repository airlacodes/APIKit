//
//  RequestSender.swift
//  APIKit
//
//  Created by Jeevan Thandi on 16/06/2019.
//  Copyright © 2019 Airla Tech Ltd. All rights reserved.
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

struct APIKitVoid: APIModel {}
