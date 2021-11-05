//
//  HTTPMethod.swift
//  APIKit
//
//  Created by Codeonomics on 05/11/2021.
//  Copyright © 2021 Codeonomics.io All rights reserved.
//

import Foundation

public enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
    case patch = "PATCH"
}

public typealias HttpHeaders = [String: String]
