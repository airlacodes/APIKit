//
//  APIKit.swift
//  APIKit
//
//  Created by Codeonomics on 07/11/2021.
//  Copyright © 2021 Codeonomics.io All rights reserved.
//

import Foundation

public final class APIKit {
        
    private init() {}
    
    public static var refreshTokenPath: String = ""
    
    public static var requestInterceptor: APIKitRequestInterceptor?
    
    public static var credentials: Credentials? {
        set(newCredentials) {
            if let creds = newCredentials {
                APIKitCredentialsStore().save(credentials: creds)
            }
        }
        
        get {
            APIKitCredentialsStore().getCurrentCredentials()
        }
    }
}

