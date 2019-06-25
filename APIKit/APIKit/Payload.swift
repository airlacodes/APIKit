//
//  Package.swift
//  APIKit
//
//  Created by Jeevan Thandi on 17/06/2019.
//  Copyright © 2019 Airla Tech Ltd. All rights reserved.
//

import Foundation

public struct Payload {
    let body: APIModel?
    let endpoint: APIEndpoint

    public init(body: APIModel? = nil,
                endpoint: APIEndpoint) {
        self.body = body
        self.endpoint = endpoint
    }
}
