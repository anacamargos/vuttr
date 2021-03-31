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
    private let responseDecoder: NetworkResponseDecoder
    
    // MARK: - Initializers
    
    init(
        httpClient: HTTPClient,
        responseDecoder: NetworkResponseDecoder
    ) {
        self.httpClient = httpClient
        self.responseDecoder = responseDecoder
    }
    
    // MARK: - NetworkDispatcher
    
    func dispatch(_ request: NetworkRequest, then handle: @escaping (Result<NetworkResponse, NetworkError>) -> Void) {
        let url = URL(string: "google.com")!
        httpClient.get(from: url) { result in
            handle(result)
        }
    }
    
    func requestCodable<T>(ofType type: T.Type, for request: NetworkRequest, then handle: @escaping (Result<T?, NetworkError>) -> Void) where T : Decodable, T : Encodable {
        dispatch(request) { [weak self] result in
            self?.responseDecoder.decodeDataRequestResult(result, ofType: type, then: handle)
        }
    }
}
