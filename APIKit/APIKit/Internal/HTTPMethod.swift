//
//  HTTPMethod.swift
//  APIKit
//
//  Created by Jeevan Thandi on 16/06/2019.
//  Copyright © 2019 Airla Tech Ltd. All rights reserved.
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
typealias HttpStatusCode = Int

struct HttpResponse {
    let code: HttpStatusCode
    let data: Data

    init(code: HttpStatusCode, data: Data) {
        self.code = code
        self.data = data
    }

    func decodeData<T: Decodable>(ofType type: T.Type) -> T? {
        return decode(ofType: T.self)
    }

    func decode<T: Decodable>(ofType type: T.Type) -> T? {
        var decoded: T?
        do {
            decoded = try JSONDecoder().decode(type, from: data)
        } catch let error {
            print("Error decoding JSON: \(error) MODEL: \(type)")
        }
        return decoded
    }
}

enum HttpStatus: Int {
    static let maxValueSuccessCode = 299

    case success = 201
    case badRequest = 400
    case serverError = 500
}
