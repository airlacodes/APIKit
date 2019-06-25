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

    private let request: RequestSender
    private let endpoint: APIEndpoint
    private let body: APIModel?

    init(requestSender: RequestSender = HTTPRequestSender(),
         endpoint: APIEndpoint,
         body: APIModel? = nil) {
        self.request = requestSender
        self.endpoint = endpoint
        self.body = body
    }

    open func execute(callback: @escaping (Result<Response, APIError>) -> Void) {
        let payload = Payload(body: body,
                              endpoint: endpoint)

        request.request(payload: payload, callback: { response in
            guard let res = response.decode(ofType: Response.self) else {
                return
            }
            callback(Result.success(value: res))
        })
    }

    open func observable(pollTime: Int) -> Observable<Response> {
        let payload = Payload(body: body,
                              endpoint: endpoint)

        // let observerId = payload.hashValue (to keep unique observers and not return duplicate ones) ?
        return Observable(pollTime: 5, payload: payload)
    }
}
