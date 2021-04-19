//
//  NetworkDispatcherMock.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 15/04/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation
@testable import VeryUsefulToolstoRemember

final class NetworkDispatcherMock<T: Codable>: NetworkDispatcher {

    var dispatchResultToBeReturned: Result<NetworkResponse, NetworkError> = .success(.init(status: .http(200), data: nil))
    private(set) var dispatchPassedRequests = [NetworkRequest]()

    func dispatch(_ request: NetworkRequest, then handle: @escaping (Result<NetworkResponse, NetworkError>) -> Void) {
        dispatchPassedRequests.append(request)
        handle(dispatchResultToBeReturned)
    }

    var requestCodableResultToBeReturned: Result<T?, NetworkError> = .success(nil)
    private(set) var requestCodablePassedRequests = [NetworkRequest]()

    func requestCodable<T>(ofType type: T.Type, for request: NetworkRequest, then handle: @escaping (Result<T?, NetworkError>) -> Void) where T: Decodable, T: Encodable {
        requestCodablePassedRequests.append(request)
        switch requestCodableResultToBeReturned {
        case let .failure(error):
            handle(.failure(error))
        case let .success(anyValue):
            var valueToReturn: T?
            if let anyValue = anyValue, let castedValue = anyValue as? T {
                valueToReturn = castedValue
            }
            handle(.success(valueToReturn))
        }
    }
}
