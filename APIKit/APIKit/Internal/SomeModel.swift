//
//  SomeModel.swift
//  APIKit
//
//  Created by Codeonomics on 16/06/2019.
//  Copyright © 2019 Codeonomics.io All rights reserved.
//

import Foundation

struct SomeModel: APIModel {

    let someProperty: String
}

struct SomeResponse: APIModel {
    let someProperty: Int
}
