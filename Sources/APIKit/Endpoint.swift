//
//  Endpoint.swift
//  APIKit
//
//  Created by Codeonomics on 09/07/2019.
//

import Foundation

public struct Endpoint {
    public let path: String
    public let method: HttpMethod
    public var requestPayload: APIModel?
    public var authenticated: Bool = true
    
    public init(path: String, method: HttpMethod = .post, requestPayload: APIModel? = nil, authenticated: Bool = true) {
        self.path = path
        self.method = method
        self.requestPayload = requestPayload
        self.authenticated = authenticated
    }
}
