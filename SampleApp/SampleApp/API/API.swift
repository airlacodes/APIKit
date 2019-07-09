//
//  API.swift
//  SampleApp
//
//  Created by Jeevan Thandi on 09/07/2019.
//  Copyright © 2019 Airla Tech Ltd. All rights reserved.
//

import APIKit

struct API {

    static func getPost(id: Int) -> APICall<Post> {
        return APICall<Post>(endpoint: getPostEndpoint(id: id))
    }

    private static func getPostEndpoint(id: Int) -> Endpoint {
        return Endpoint(path: "https://jsonplaceholder.typicode.com/posts/\(id)", method: .get)
    }
}
