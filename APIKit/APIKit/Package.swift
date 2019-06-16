//
//  Package.swift
//  APIKit
//
//  Created by Jeevan Thandi on 17/06/2019.
//  Copyright © 2019 Airla Tech Ltd. All rights reserved.
//

import Foundation

public class Package<Response: APIModel> {
    let payload: APIModel
    let endpoint: APIEndpoint

    init(payload: APIModel,
         endpoint: APIEndpoint) {
        self.payload = payload
        self.endpoint = endpoint
    }
}
