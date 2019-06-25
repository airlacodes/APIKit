//
//  Demo.swift
//  APIKit
//
//  Created by Jeevan Thandi on 17/06/2019.
//  Copyright © 2019 Airla Tech Ltd. All rights reserved.
//

import Foundation

class Demo {
    
    private let someAPICall: APICall<SomeResponse>

    public var somePublicVariable: Int?

    init(someAPICall: APICall<SomeResponse> = API().someEndpoint()) {
        self.someAPICall = someAPICall
    }

    func some() {
        someAPICall.execute { [weak self] result in
            switch result {
            case .success(let val): self?.somePublicVariable = val.someProperty
            case .failure(let error): print(error)
            }
        }
    }


}
