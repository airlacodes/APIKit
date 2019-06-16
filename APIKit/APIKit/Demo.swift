//
//  Demo.swift
//  APIKit
//
//  Created by Jeevan Thandi on 17/06/2019.
//  Copyright © 2019 Airla Tech Ltd. All rights reserved.
//

import Foundation

class Demo {

    func some() {

        let requestBody = SomeModel(string: "me")
        let endpoint = APIEndpoint.custom(path: "/some", method: .post)
        let payload = Payload(body: requestBody, endpoint: endpoint)

        let apiCall = APICall<SomeModel>(payload: payload)

        apiCall.execute(callback: { response in
            print(response.string)
        })

    }
}
