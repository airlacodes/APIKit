//
//  TokenRefresher.swift
//  APIKit
//
//  Created by Codeonomics on 07/11/2021.
//  Copyright © 2021 Codeonomics.io All rights reserved.
//

import Foundation

protocol TokenRefresher {
    func refresh(completion: @escaping (TokenRefreshResult)-> Void)
    var credentialsStore: CredentialsStore { get }
}

enum TokenRefreshResult {
    case refreshed
    case refreshFailed
    case shouldRetry
}

final class APIKitTokenRefresher: TokenRefresher {
  
    private let requestSender: RequestSender = HTTPRequestSender()
    
    var credentialsStore: CredentialsStore {
        return APIKitCredentialsStore()
    }
    
    struct RefreshTokenRequest: APIModel {
        let refreshToken: String
        
        enum CodingKeys: String, CodingKey {
            case refreshToken = "refresh_token"
        }
    }
    
    func refresh(completion: @escaping (TokenRefreshResult) -> Void ) {
        
        guard let refreshToken = credentialsStore.getCurrentCredentials()?.refreshToken else {
            completion(.refreshFailed)
            return
        }
        
        let refreshEndpoint = Endpoint(path: APIKit.refreshTokenPath,
                                       method: .post,
                                       requestPayload: RefreshTokenRequest(refreshToken: refreshToken),
                                       authenticated: false)
        
        requestSender.request(endpoint: refreshEndpoint, callback: { [weak self] refreshResult in
            switch refreshResult {
            case .success(let data):
                if let newCredentials = HttpResponse(code: 200, data: data).decodeData(ofType: Credentials.self) {
                    self?.credentialsStore.save(credentials: newCredentials)
                } else {
                    completion(.refreshFailed)
                }
            case .failure(_ ):
                completion(.refreshFailed)
            }
        })
    }
}
