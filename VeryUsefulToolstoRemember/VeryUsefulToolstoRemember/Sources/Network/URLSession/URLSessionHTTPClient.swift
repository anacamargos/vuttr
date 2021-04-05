//
//  URLSessionHTTPClient.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 25/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation

protocol HTTPClient {
    func get(from networkRequest: NetworkRequest, then handle: @escaping (Result<NetworkResponse, NetworkError>) -> Void)
}

final class URLSessionHTTPClient: HTTPClient {
    
    // MARK: - Dependencies
    
    private let session: URLSessionProvider
    private let networkRequestBuilder: NetworkRequestBuilder.Type
    private let configuration: NetworkConfiguration
    
    // MARK: - Initializer
    
    init(
        session: URLSessionProvider,
        networkRequestBuilder: NetworkRequestBuilder.Type = DefaultRequestBuilder.self,
        configuration: NetworkConfiguration
    ) {
        self.session = session
        self.networkRequestBuilder = networkRequestBuilder
        self.configuration = configuration
    }
    
    // MARK: - Private Methods
    
    private func handleFailure(with error: Error, then handle: @escaping (Result<NetworkResponse, NetworkError>) -> Void) {
        let nsError = error as NSError
        let requestError = RequestError.http(nsError.code)
        let networkError = NetworkError(requestError: requestError, rawError: nsError)
        handle(.failure(networkError))
    }
    
    private func handleSuccess(with data: Data, response: HTTPURLResponse, then handle: @escaping (Result<NetworkResponse, NetworkError>) -> Void) {
        let networkResponse = NetworkResponse(status: .http(response.statusCode), data: data)
        handle(.success(networkResponse))
    }
    
    // MARK: - HTTPClient
    
    func get(
        from networkRequest: NetworkRequest,
        then handle: @escaping (Result<NetworkResponse, NetworkError>) -> Void
    ) {
        do {
            let urlRequest = try networkRequestBuilder.init(
                request: networkRequest,
                networkConfiguration: configuration
            ).build()
            session.dataTask(with: urlRequest) { [weak self] data, response, error in
                if let error = error {
                    self?.handleFailure(with: error, then: handle)
                } else if let data = data, let response = response as? HTTPURLResponse {
                    self?.handleSuccess(with: data, response: response, then: handle)
                } else {
                    handle(.failure(.init(.internal(.invalidHTTPResponse))))
                }
            }.resume()
        } catch {
            let internalError = error as? RequestError.Internal ?? .unexpected
            handle(.failure(.init(.internal(internalError))))
        }
    }
}
