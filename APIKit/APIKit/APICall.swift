//
//  Call.swift
//  APIKit
//
//  Created by Jeevan Thandi on 16/06/2019.
//  Copyright © 2019 Airla Tech Ltd. All rights reserved.
//

import Foundation

class APICall<Response: APIModel>: Call {
    typealias ResponseType = Response

    private let request: RequestSender
    private let payload: Payload

    init(requestSender: RequestSender = HTTPRequestSender(),
         payload: Payload) {
        self.request = requestSender
        self.payload = payload
    }

    func execute(callback: @escaping (Result<ResponseType, APIError>) -> Void) {
        request.request(payload: payload, callback: { response in
            guard let res = response.decode(ofType: Response.self) else {
                return
            }
            callback(Result.success(value: res))
        })
    }

    func cancel() {
        request.cancelNetworkRequest()
    }
}
