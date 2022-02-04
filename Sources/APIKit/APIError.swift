//
//  APIError.swift
//  APIKit
//
//  Created by Codeonomics on 23/06/2019.
//

import Foundation

public enum APIError: Error {
    case unexpectedError
    case unauthorised
    case modelDecodingFailed(data: Data)
    case responseError(object: Data)
}
