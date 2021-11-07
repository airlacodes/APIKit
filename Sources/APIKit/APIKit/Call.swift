//
//  Call.swift
//  APIKit
//
//  Created by Codeonomics on 16/06/2019.
//  Copyright © 2019 Codeonomics.io All rights reserved.
//

import Foundation

public protocol Call {
    associatedtype Response: APIModel
    func execute(callback: @escaping APICallback<Response>)
    func observable(pollTime: Int) -> Observable<Response>
}
