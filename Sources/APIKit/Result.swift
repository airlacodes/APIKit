//
//  Result.swift
//  APIKit
//
//  Created by Codeonomics on 23/06/2019.
//  Copyright © 2019 Codeonomics.io All rights reserved.
//

import Foundation

public enum Result<Value: APIModel> {
    case success(value: Value)
    case failure(error: Error)
    
    public func successValue() -> Value? {
        if case .success(let value) = self {
            return value
        }
        
        return nil
    }
}



internal enum NetworkResult {
    case success(_ : Data)
    case failure(_ : Error)
}
