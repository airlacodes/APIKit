//
//  Observable.swift
//  APIKit
//
//  Created by Jeevan Thandi on 23/06/2019.
//  Copyright © 2019 Airla Tech Ltd. All rights reserved.
//

import Foundation

public class Observable<T: APIModel> {

    private let request: RequestSender
    private let payload: Payload
    private let pollTime: Int

    init(request: RequestSender = HTTPRequestSender(), payload: Payload, pollTime: Int) {
        self.request = request
        self.payload = payload
        self.pollTime = pollTime
    }

    func observe(_ callback: APIKitCallback<T>) {

    }

    func stop() {

    }
}

