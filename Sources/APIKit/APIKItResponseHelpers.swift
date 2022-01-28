//
//  APIKItResponseHelpers.swift
//  APIKit
//
//  Created by Codeonomics on 20/11/2021.
//  Copyright © 2021 All rights reserved.
//

import Foundation

public struct APIKitVoid: APIModel {
    public let data: Data
}

public struct APIKitArrayResponse<Items: APIModel>: APIModel {
    public let items: [Items]
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        items = try container.decode([Items].self)
    }
}

public struct APIKitOptionalResponse<T: APIModel>: APIModel {
    public let response: T?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        response = try container.decode(T.self)
    }
}
