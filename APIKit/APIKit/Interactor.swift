//
//  Interactor.swift
//  APIKit
//
//  Created by Jeevan Thandi on 16/06/2019.
//  Copyright © 2019 Airla Tech Ltd. All rights reserved.
//

import Foundation

public protocol Interactor {
    associatedtype ResponseType
    func execute(callback: @escaping (ResponseType) -> Void)
    func cancel()
}
