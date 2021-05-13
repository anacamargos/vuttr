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

    func test_whenRequestCodableIsCalled_itShouldReturnResponseDecoderResult() {
        // Given
        let httpClientMock = HTTPClientMock()
        let sut = makeSUT(httpClient: httpClientMock)
        guard let codableMockData = """
        {
           "key": "value"
        }
        """.data(using: .utf8) else {
           XCTFail("Could not create codableMockData.")
            return
        }
        let expectedCodableObject = CodableMock(key: "value")
        let stubbedNetworkResponse = NetworkResponse(status: .http(200), data: codableMockData)
        httpClientMock.getResultToBeReturned = .success(stubbedNetworkResponse)
        let requestMock = HTTPRequest(baseURL: .string("www.test.com"), method: .get)

        // When
        let codableDataExpectation = expectation(description: "codableDataExpectation")
        var requestObjectReturned: CodableMock?
        sut.requestCodable(ofType: CodableMock.self, for: requestMock) { result in
            switch result {
            case let .success(requestObject):
                requestObjectReturned = requestObject
            case .failure:
                XCTFail("Expected .success, but got \(String(describing: result)).")
                return
            }
            codableDataExpectation.fulfill()
        }
        wait(for: [codableDataExpectation], timeout: 1.0)

        // Then
        XCTAssertEqual(requestObjectReturned, expectedCodableObject)
    }

    // MARK: - Test Helpers

    private func makeSUT(
        httpClient: HTTPClient = HTTPClientDummy(),
        file: StaticString = #file,
        line: UInt = #line
    ) -> DefaultNetworkDispatcher {
        let sut = DefaultNetworkDispatcher(httpClient: httpClient, responseDecoder: DefaultResponseDecoder())
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}
