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
    
    func test_dispatch_whenRequestSucceeds_itShouldReturnSuccessWithData() {
        // Given
        let expectedResponse = NetworkResponse(status: .http(200), data: nil)
        let httpClientMock = HTTPClientMock()
        httpClientMock.getResultToBeReturned = .success(expectedResponse)
        let sut = makeSUT(httpClient: httpClientMock)
        let htppRequest = HTTPRequest(baseURL: .string("www.a-url.com"), method: .get)
        
        // When
        let dispatchExpectation = expectation(description: "dispatch expectation")
        var receivedNetworkResponse: NetworkResponse?
        sut.dispatch(htppRequest) { result in
            switch result {
            case let .success(networkResponse):
                receivedNetworkResponse = networkResponse
            case .failure:
                XCTFail("Expected success, but got \(result) instead")
            }
            dispatchExpectation.fulfill()
        }
        wait(for: [dispatchExpectation], timeout: 1.0)
        
        // Then
        guard let receivedResponse = receivedNetworkResponse else {
            XCTFail("Could not find NetworkResponse")
            return
        }
        XCTAssertEqual(String(describing: expectedResponse), String(describing: receivedResponse))
        XCTAssertEqual(String(describing: httpClientMock.getPassedRequests), String(describing: [htppRequest]))
    }
    
    // MARK: - Test Helpers

    private func makeSUT(
        httpClient: HTTPClient = HTTPClientDummy()
    ) -> DefaultNetworkDispatcher {
        let sut = DefaultNetworkDispatcher(httpClient: httpClient, responseDecoder: DefaultResponseDecoder())
        return sut
    }
}

final class HTTPClientDummy: HTTPClient { //
    func get(from networkRequest: NetworkRequest, then handle: @escaping (Result<NetworkResponse, NetworkError>) -> Void) {}
}

final class HTTPClientMock: HTTPClient {
    
    var getResultToBeReturned: Result<NetworkResponse, NetworkError> = .success(.init(status: .http(200), data: nil))
    private(set) var getPassedRequests = [NetworkRequest]()
    
    func get(from networkRequest: NetworkRequest, then handle: @escaping (Result<NetworkResponse, NetworkError>) -> Void) {
        getPassedRequests.append(networkRequest)
        handle(getResultToBeReturned)
    }
}
