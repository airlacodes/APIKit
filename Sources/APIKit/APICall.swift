//
//  Call.swift
//  APIKit
//
//  Created by Codeonomics on 16/06/2019.
//

import Foundation

open class APICall<ResponseModel: APIModel> {
    public typealias Response = ResponseModel

    private let endpoint: Endpoint

    public init(endpoint: Endpoint) {
        self.endpoint = endpoint
    }

    open func rawDataResponse(dataCallback: @escaping (Result<APIKitVoid>) -> Void) {
        var requestSender: RequestSender?
        
        if(endpoint.authenticated) {
            requestSender = BearerRequestSender()
        } else {
            requestSender = HTTPRequestSender()
        }
        
        requestSender?.request(endpoint: self.endpoint, callback: { response in
            switch response {
            case .success(let data):
                dataCallback(Result.success(value: APIKitVoid(data: data)))
            case .failure(let error):
                dataCallback(Result.failure(error: error))
            }
        })
    }
    
    open func execute(callback: @escaping (Result<Response>) -> Void) {
        var requestSender: RequestSender?
        
        if(endpoint.authenticated) {
            requestSender = BearerRequestSender()
        } else {
            requestSender = HTTPRequestSender()
        }
        
        requestSender?.request(endpoint: self.endpoint, callback: { response in
            switch response {
            case .success(let data):
                do {
                  let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
                  callback(Result.success(value: decodedResponse))

                } catch let error {
                    callback(Result.failure(error: error))
                }
                
            case .failure(let error):
                callback(Result.failure(error: error))
            }
        })
    }

    open func observable(pollTime: Int) -> Observable<Response> {

        // let observerId = payload.hashValue (to keep unique observers and not return duplicate ones) ?
        return Observable(pollTime: 5, endpoint: self.endpoint)
    }
}
