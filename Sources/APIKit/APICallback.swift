//
//  APIKitCallback.swift
//  APIKit
//
//  Created by Codeonomics on 23/06/2019.
//

import Foundation

public typealias APICallback<T: APIModel> = (Result<T>) -> Void
