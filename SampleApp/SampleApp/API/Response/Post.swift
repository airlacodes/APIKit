//
//  Post.swift
//  SampleApp
//
//  Created by Jeevan Thandi on 09/07/2019.
//  Copyright © 2019 Airla Tech Ltd. All rights reserved.
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
