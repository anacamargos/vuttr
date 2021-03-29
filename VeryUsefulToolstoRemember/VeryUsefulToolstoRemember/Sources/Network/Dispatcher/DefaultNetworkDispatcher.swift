//
//  DefaultNetworkDispatcher.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 25/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation

final class DefaultNetworkDispatcher: NetworkDispatcher {
    
    // MARK: - Dependencies
    
    private let httpClient: HTTPClient
    
    // MARK: - Initializers
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    // MARK: - NetworkDispatcher
    
    func dispatch(_ request: NetworkRequest, then handle: @escaping (Result<NetworkResponse, NetworkError>) -> Void) {
        httpClient.get(from: request.url) { result in
            handle(result)
        }
    }
    
    func requestCodable<T>(ofType type: T.Type, for request: NetworkRequest, then handle: @escaping (Result<T?, NetworkError>) -> Void) where T : Decodable, T : Encodable {
        dispatch(request) { result in
            
        }
    }
}
