//
//  Observable.swift
//  APIKit
//
//  Created by Codeonomics on 23/06/2019.
//  Copyright © 2019 Codeonomics.io All rights reserved.
//

import Foundation

public class Observable<T: APIModel> {

    private let endpoint: Endpoint
    private let pollTime: Int
    internal var request: RequestSender = HTTPRequestSender()

    public init(pollTime: Int, endpoint: Endpoint) {
        self.pollTime = pollTime
        self.endpoint = endpoint
    }

    func observe(_ callback: APICallback<T>) {

    }

    func stop() {

    }
}

