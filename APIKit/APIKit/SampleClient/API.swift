//
//  API.swift
//  APIKitTests
//
//  Created by Jeevan Thandi on 25/06/2019.
//  Copyright © 2019 Airla Tech Ltd. All rights reserved.
//

import Foundation

class API {

    func someEndpoint() -> APICall<SomeResponse> {
        return APICall<SomeResponse>(endpoint: Endpoint(path: "some"))
    }
}
