//
//  APIKitCallback.swift
//  APIKit
//
//  Created by Codeonomics on 23/06/2019.
//  Copyright © 2019 Codeonomics.io All rights reserved.
//

import Foundation

public typealias APICallback<T: APIModel> = (Result<T, APIError>) -> Void
