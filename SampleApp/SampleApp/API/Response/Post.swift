//
//  Post.swift
//  SampleApp
//
//  Created by Codeonomics on 09/07/2019.
//  Copyright © 2019 Codeonomics.io All rights reserved.
//

import APIKit

struct Post: APIModel {
    let userId: Int
    let id: Int
    let title: String
    let body: String


    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case id = "id"
        case title
        case body
    }
}
