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

        let payload = SomeModel(string: "me")
        let endpoint = APIEndpoint.custom(path: "/some", method: .post)
        let package = Package<SomeModel>(payload: payload, endpoint: endpoint)

        let interactor = APIInteractor<SomeModel>(package: package)

        interactor.execute(callback: { response in
            print(response.string)
        })

    }
}
