//
//  Result.swift
//  APIKit
//
//  Created by Jeevan Thandi on 23/06/2019.
//  Copyright © 2019 Airla Tech Ltd. All rights reserved.
//

import Foundation

public enum Result<Value: APIModel, Error> {

    case success(value: Value)
    case failure(error: Error)
}

enum NetworkResult {
    case success(_ : Data)
    case failure(_ : Error)
}
