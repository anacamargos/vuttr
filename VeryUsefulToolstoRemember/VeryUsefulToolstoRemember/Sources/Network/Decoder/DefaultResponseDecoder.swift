//
//  DefaultResponseDecoder.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 29/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation

final class DefaultResponseDecoder: NetworkResponseDecoder {
    
    // MARK: - Dependencies
    
    private let jsonDecoder: JSONDecoder
    
    // MARK: - Initializer
    
    init(jsonDecoder: JSONDecoder = .init()) {
        self.jsonDecoder = jsonDecoder
    }
    
    // MARK: - Decoding Logic
    
    func decodeDataRequestResult<T>(_ result: Result<NetworkResponse, NetworkError>, ofType: T.Type, then handle: @escaping (Result<T?, NetworkError>) -> Void) where T : Decodable, T : Encodable {
        switch result {
        case let .success(networkResponse):
            decodeSuccessResponseData(networkResponse.data, then: handle)
        case let .failure(networkError):
            handle(.failure(networkError))
        }
    }
    
    // MARK: - Private Methods
    
    private func decodeSuccessResponseData<T: Codable>(
        _ data: Data?,
        then handle: @escaping (Result<T?, NetworkError>) -> Void
    ){
        guard let data = data, !data.isEmpty else {
            handle(.success(nil))
            return
        }
        do {
            let decodedResponse = try jsonDecoder.decode(T.self, from: data)
            handle(.success(decodedResponse))
        } catch {
            var errorMessage = """
            [uNetwork - Decoding Error]\n
            \(error) \n
            """
            if let dataString = String(data: data, encoding: .utf8) {
                errorMessage += "[uNetwotk - Decoded Object]\n\(dataString)"
            }
            debugPrint(errorMessage)
            handle(.failure(.init(.internal(.objectDecoding))))
        }
    }
}
