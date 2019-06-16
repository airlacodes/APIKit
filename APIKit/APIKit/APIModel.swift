//
//  APIModel.swift
//  APIKit
//
//  Created by Jeevan Thandi on 17/06/2019.
//  Copyright © 2019 Airla Tech Ltd. All rights reserved.
//

import Foundation

public protocol APIModel: Codable {
    func encode() -> Data?

    func equals(_ item: APIModel) -> Bool
}

extension APIModel {

    public func encode() -> Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch let error {
            print("----Error Encoding model: \(self) | Reason: \(error.localizedDescription)")
            return nil
        }
    }

    public func equals(_ item: APIModel) -> Bool {
        return self.encode() == item.encode()
    }
}

extension Array: APIModel where Element: APIModel {}
