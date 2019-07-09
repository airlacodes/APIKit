//
//  Call.swift
//  APIKit
//
//  Created by Jeevan Thandi on 16/06/2019.
//  Copyright © 2019 Airla Tech Ltd. All rights reserved.
//

import Foundation

open class APICall<ResponseModel: APIModel> {
    public typealias Response = ResponseModel

    private let endpoint: Endpoint
    private let request: RequestSender = HTTPRequestSender()

    public init(endpoint: Endpoint) {
        self.endpoint = endpoint
    }

    open func execute(callback: @escaping (Result<Response, APIError>) -> Void) {
        request.request(endpoint: self.endpoint, callback: { response in
            switch response {
            case .success(let data):
                guard let res = try? JSONDecoder().decode(Response.self, from: data) else {
                    return
                }

                callback(Result.success(value: res))
            case .failure(let error):
                print("ERROR IN APICALL: ", error)
                callback(Result.failure(error: APIError.networokingError))
            }
        })
    }

    open func observable(pollTime: Int) -> Observable<Response> {

        // let observerId = payload.hashValue (to keep unique observers and not return duplicate ones) ?
        return Observable(pollTime: 5, endpoint: self.endpoint)
    }
}
