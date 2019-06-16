//
//  Interactor.swift
//  APIKit
//
//  Created by Jeevan Thandi on 16/06/2019.
//  Copyright © 2019 Airla Tech Ltd. All rights reserved.
//

import Foundation

final class APIInteractor<Response: APIModel>: Interactor {
    typealias ResponseType = Response


    private let request: RequestSender
    private let package: Package<Response>

    init(requestSender: RequestSender = HTTPRequestSender(),
         package: Package<Response>) {
        self.request = requestSender
        self.package = package
    }

    func execute(callback: @escaping (ResponseType) -> Void) {
        request.request(payload: package.payload, endpoint: package.endpoint, callback: { response in
            guard let res = response.decode(ofType: Response.self) else {
                return
            }
            callback(res)
        })
    }

    func cancel() {
        request.cancelNetworkRequest()
    }
}
