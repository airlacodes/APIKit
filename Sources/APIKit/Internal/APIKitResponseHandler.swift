//
//  APIKitResponseHandler.swift
//  APIKit
//
//  Created by Codeonomics on 07/11/2021.
//  Copyright © 2021 Codeonomics.io All rights reserved.
//

import Foundation


protocol ResponseHandler {
    func handle(response: URLResponse?, data: Data, completion: (NetworkResult) -> Void)
}

class APIKitResponseHandler: ResponseHandler {
    
    enum HttpStatus: Int {
        static let maxValueSuccessCode = 299

        case success = 201
        case badRequest = 400
        case serverError = 500
    }
    
    func handle(response: URLResponse?, data: Data, completion: (NetworkResult) -> Void) {
        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 404
        
        if isValid(statusCode: statusCode) {
            completion(.success(data))
        } else {
            completion(.failure(APIError.responseError(object: data)))
        }
    }
    
    private func isValid(statusCode: Int) -> Bool {
        return statusCode <= HttpStatus.maxValueSuccessCode
    }
}
