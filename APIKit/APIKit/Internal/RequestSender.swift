//
//  RequestSender.swift
//  APIKit
//
//  Created by Jeevan Thandi on 16/06/2019.
//  Copyright © 2019 Airla Tech Ltd. All rights reserved.
//

import Foundation

protocol RequestSender {
    func request(payload: Payload,
                 callback: @escaping (HttpResponse) -> Void)
    func cancelNetworkRequest()
}
