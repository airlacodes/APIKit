//
//  MockAPICall.swift
//  APIKit
//
//  Created by Codeonomics on 17/12/2021.
//  Copyright © 2021 Airla Tech Ltd. All rights reserved.
//

import Foundation

/// Inject this into your Object(s) Under Test to trigger mock results for unit testing where 'T' is the expected Response of the call
public class MockAPICall<T: APIModel>: APICall<T> {

    private var callback: APICallback<T>?
    public var didCallExecute: Bool = false
    
    override init(endpoint: Endpoint = .init(path: "")) {
        super.init(endpoint: endpoint)
    }
    
    public override func execute(callback: @escaping (Result<T>) -> Void) {
        self.callback = callback
        didCallExecute = true
    }
    
    public func triggerSuccess(_ value: T) {
        callback?(.success(value: value))
    }
    
    public func triggerFailure(_ error: Error) {
        callback?(.failure(error: error))
    }
}
