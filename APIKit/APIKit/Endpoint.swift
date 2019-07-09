//
//  Endpoint.swift
//  APIKit
//
//  Created by Jeevan Thandi on 09/07/2019.
//  Copyright © 2019 Airla Tech Ltd. All rights reserved.
//

import Foundation

public struct Endpoint {
    public let path: String
    public let method: HttpMethod
    public var requestPayload: APIModel?

    public init(path: String, method: HttpMethod = .post, requestPayload: APIModel? = nil) {
        self.path = path
        self.method = method
        self.requestPayload = requestPayload
    }
}
