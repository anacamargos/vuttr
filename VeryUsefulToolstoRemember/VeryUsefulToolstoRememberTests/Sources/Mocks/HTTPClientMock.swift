//
//  HTTPClientMock.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 12/04/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation
@testable import VeryUsefulToolstoRemember

final class HTTPClientMock: HTTPClient {
    
    var getResultToBeReturned: Result<NetworkResponse, NetworkError> = .success(.init(status: .http(200), data: nil))
    private(set) var getPassedRequests = [NetworkRequest]()
    
    func get(from networkRequest: NetworkRequest, then handle: @escaping (Result<NetworkResponse, NetworkError>) -> Void) {
        getPassedRequests.append(networkRequest)
        handle(getResultToBeReturned)
    }
}
