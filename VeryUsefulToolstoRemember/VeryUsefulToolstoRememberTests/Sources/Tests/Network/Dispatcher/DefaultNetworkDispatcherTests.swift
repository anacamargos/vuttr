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
    
    func test_dispatch_whenRequestFails_shouldReturnCorrectNetworkError() {
        // Given
        let expectedNetworkError = NetworkError(.http(400))
        let httpClientMock = HTTPClientMock()
        httpClientMock.getResultToBeReturned = .failure(expectedNetworkError)
        let sut = makeSUT(httpClient: httpClientMock)
        let htppRequest = HTTPRequest(baseURL: .string("www.a-url.com"), method: .get)
        
        // When
        let dispatchExpectation = expectation(description: "dispatch expectation")
        var receivedNetworkError: NetworkError?
        sut.dispatch(htppRequest) { result in
            switch result {
            case .success:
                XCTFail("Expected failure, but got \(result) instead")
            case let .failure(error):
                receivedNetworkError = error
            }
            dispatchExpectation.fulfill()
        }
        wait(for: [dispatchExpectation], timeout: 1.0)
        
        // Then
        guard let receivedError = receivedNetworkError else {
            XCTFail("Could not find NetworkResponse")
            return
        }
        XCTAssertEqual(String(describing: expectedNetworkError), String(describing: receivedError))
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
