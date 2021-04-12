//
//  DefaultNetworkDispatcherTests.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 12/04/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import XCTest
@testable import VeryUsefulToolstoRemember

final class DefaultNetworkDispatcherTests: XCTestCase {
    
    // MARK: - Test Helpers

    private func makeSUT(
        httpClient: HTTPClient = HTTPClientDummy()
    ) -> DefaultNetworkDispatcher {
        let sut = DefaultNetworkDispatcher(httpClient: httpClient, responseDecoder: DefaultResponseDecoder())
        return sut
    }
}

final class HTTPClientDummy: HTTPClient {
    func get(from networkRequest: NetworkRequest, then handle: @escaping (Result<NetworkResponse, NetworkError>) -> Void) {}
}
