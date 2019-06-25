//
//  Observable.swift
//  APIKit
//
//  Created by Jeevan Thandi on 23/06/2019.
//  Copyright © 2019 Airla Tech Ltd. All rights reserved.
//

import Foundation

public class Observable<T: APIModel> {

    private let payload: Payload
    private let pollTime: Int
    internal var request: RequestSender = HTTPRequestSender()

    public init(pollTime: Int, payload: Payload) {
        self.pollTime = pollTime
        self.payload = payload
    }

    func observe(_ callback: APICallback<T>) {

    }

    func stop() {

    }
}

