//
//  HTTPMethod.swift
//  APIKit
//
//  Created by Codeonomics on 16/06/2019.
//  Copyright © 2019 Codeonomics.io All rights reserved.
//

import Foundation

struct HttpResponse {
    let code: Int
    let data: Data

    init(code: Int, data: Data) {
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
