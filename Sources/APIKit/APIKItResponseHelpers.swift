//
//  APIKItResponseHelpers.swift
//  APIKit
//
//  Created by Codeonomics on 20/11/2021.
//  Copyright © 2021 Airla Tech Ltd. All rights reserved.
//

import Foundation

public struct APIKitVoid: APIModel {}

public struct APIKitArrayResponse<Items: APIModel>: APIModel {
    let items: [Items]
    
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        print("APIKIT: APIKitArrayResponse: container: ", container)
        items = try container.decode([Items].self)
    }
}

