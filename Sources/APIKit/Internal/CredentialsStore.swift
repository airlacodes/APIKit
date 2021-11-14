//
//  JWTProvider.swift
//  APIKit
//
//  Created by Codeonomics on 07/11/2021.
//  Copyright © 2021 Codeonomics.io All rights reserved.
//

import Foundation

protocol CredentialsStore {
    func save(credentials: Credentials)
    func getCurrentCredentials() -> Credentials?
    func shouldRefreshCredentials() -> Bool
    func userProfileDataFromCredentials() -> Data?
}

final class APIKitCredentialsStore: CredentialsStore {
    
    private let dataStore: UserDefaults
    private let currentCredentialsExpiry = "current_credentials_expiry"
    private let currentCredentials = "credentials_data_key"
    private let currentUserData = "current_user_data_key"
    
    init(dataStore: UserDefaults = UserDefaults.standard) {
        self.dataStore = dataStore
    }
    
    func save(credentials: Credentials) {
        let encodedCredentials = credentials.encode()
        let expiryDate = Date().addingTimeInterval(Double(credentials.expiresIn))

        dataStore.set(expiryDate, forKey: currentCredentialsExpiry)
        dataStore.set(encodedCredentials, forKey: currentCredentials)
    }
    
    func getCurrentCredentials() -> Credentials? {
        
        guard let rawCredentialsData = dataStore.value(forKey: currentCredentials) as? Data else {
            return nil
        }
        
        guard let decodedCredentials = try? JSONDecoder().decode(Credentials.self,
                                                                 from: rawCredentialsData) else {
            return nil
        }
        
        if(shouldRefreshCredentials()) {
            return nil
        } else {
            return decodedCredentials
        }
    }
    
    func shouldRefreshCredentials() -> Bool {
        guard let expiryDate = dataStore.value(forKey: currentCredentialsExpiry) as? Date else {
            return true
        }

        let timeToExpiration = expiryDate.timeIntervalSince1970 - Date().timeIntervalSince1970
        return timeToExpiration < Constants.MaxTimeIntervalToRefreshToken
    }

    private struct Constants {
        static let MaxTimeIntervalToRefreshToken = TimeInterval(30) // 30 sec
    }
    
    func userProfileDataFromCredentials() -> Data? {
        return nil
    }
}

public struct Credentials: APIModel {
    
    let accessToken: String
    let refreshToken: String
    let expiresIn: Int
    
    public init(accessToken: String, refreshToken: String, expiresIn: Int) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.expiresIn = expiresIn
    }
    
    enum CodingKeys: String, CodingKey  {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expiresIn = "expires_in"
    }
}
