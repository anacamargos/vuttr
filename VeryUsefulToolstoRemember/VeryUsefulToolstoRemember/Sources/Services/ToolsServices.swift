//
//  ToolsServices.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 14/04/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation

enum ToolsServiceError: Error {
    case responseParse
    case genericError
}

protocol ToolsServicesProvider {
    func getAllTools(then handle: @escaping (Result<[ToolResponseEntity], ToolsServiceError>) -> Void)
}

final class ToolsServices: ToolsServicesProvider {
    
    // MARK: - Dependencies
    
    private let networkDispatcher: NetworkDispatcher
    
    // MARK: - Initializers
    
    init(networkDispatcher: NetworkDispatcher) {
        self.networkDispatcher = networkDispatcher
    }
    
    // MARK: - ToolsServicesProvider
    
    func getAllTools(then handle: @escaping (Result<[ToolResponseEntity], ToolsServiceError>) -> Void) {
        let request = ToolsRequest.getTools
        execute(request: request, then: handle)
    }
    
    // MARK: - Private Methods
    
    private func execute<T: Codable>(
        request: ToolsRequest,
        then handle: @escaping (Result<T, ToolsServiceError>) -> Void
    ) {
        networkDispatcher.requestCodable(ofType: T.self, for: request) { result in
            do {
                guard let data = try result.get() else {
                    handle(.failure(.responseParse))
                    return
                }
                handle(.success(data))
            } catch {
                handle(.failure(.genericError))
            }
        }
    }
}
