//
//  APIKitCallback.swift
//  APIKit
//
//  Created by Jeevan Thandi on 23/06/2019.
//  Copyright © 2019 Airla Tech Ltd. All rights reserved.
//

import Foundation

public typealias APICallback<T: APIModel> = (Result<T, APIError>) -> Void
