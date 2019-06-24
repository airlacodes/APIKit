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

        let requestBody = SomeModel(someProperty: "abc")
        let endpoint = APIEndpoint.custom(path: "/some", method: .post)
        let payload = Payload(body: requestBody, endpoint: endpoint)

        let apiCall = APICall<SomeResponse>(payload: payload)

        apiCall.execute { result in
            switch result {
            case .success(let val): print(val)
            case .failure(let error): print(error)
            }
        }

        
    }


}
