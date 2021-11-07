//
//  RequestInterceptor.swift
//  APIKit
//
//  Created by Codeonomics on 07/11/2021.
//  Copyright © 2021 Codeonomics.io All rights reserved.
//

import Foundation

public protocol APIKitRequestInterceptor {
    func sendWithHeaders(endpoint: Endpoint) -> [String : String]
}
