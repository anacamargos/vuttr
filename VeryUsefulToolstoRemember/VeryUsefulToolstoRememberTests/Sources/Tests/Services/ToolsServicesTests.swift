//
//  ToolsServicesTests.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 15/04/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import XCTest
@testable import VeryUsefulToolstoRemember

final class ToolsServicesTests: XCTestCase {

    func test_getAllTools_whenRequestFails_shouldReturnCorrectError() {
        // Given
        let dispatcherMock = NetworkDispatcherMock<[ToolResponseEntity]>()
        let sut = makeSUT(networkDispatcher: dispatcherMock)
        let errorMock = NetworkError(.internal(.noInternetConnection))
        dispatcherMock.requestCodableResultToBeReturned = .failure(errorMock)
        let expectedError = ToolsServiceError.genericError

        // When
        getAllToolsExpect(sut, toCompleteWith: .failure(expectedError))

        // Then
        XCTAssertEqual(String(describing: dispatcherMock.requestCodablePassedRequests), String(describing: [ToolsRequest.getTools]))
    }

    func test_getAllTools_whenRequestSucceeds_butResponseIsInvalid_shouldReturnCorrectError() {
        // Given
        let dispatcherMock = NetworkDispatcherMock<[ToolResponseEntity]>()
        let sut = makeSUT(networkDispatcher: dispatcherMock)
        dispatcherMock.requestCodableResultToBeReturned = .success(nil)
        let expectedError = ToolsServiceError.responseParse

        // When
        getAllToolsExpect(sut, toCompleteWith: .failure(expectedError))

        // Then
        XCTAssertEqual(String(describing: dispatcherMock.requestCodablePassedRequests), String(describing: [ToolsRequest.getTools]))
    }

    func test_getAllTools_whenRequestSucceedsWithValidResponse_shouldReturnCorrectData() {
        // Given
        let dispatcherMock = NetworkDispatcherMock<[ToolResponseEntity]>()
        let sut = makeSUT(networkDispatcher: dispatcherMock)
        dispatcherMock.requestCodableResultToBeReturned = .success([.mock])
        let expectedResponse = [ToolResponseEntity.mock]

        // When
        getAllToolsExpect(sut, toCompleteWith: .success(expectedResponse))

        // Then
        XCTAssertEqual(String(describing: dispatcherMock.requestCodablePassedRequests), String(describing: [ToolsRequest.getTools]))
    }

    func test_deleteTool_whenRequestFails_shouldReturnCorrectError() {
        // Given
        let dispatcherMock = NetworkDispatcherMock<NoEntity>()
        let sut = makeSUT(networkDispatcher: dispatcherMock)
        let errorMock = NetworkError(.internal(.noInternetConnection))
        dispatcherMock.dispatchResultToBeReturned = .failure(errorMock)
        let expectedError = ToolsServiceError.genericError

        // When
        deleteToolExpect(sut, toCompleteWith: .failure(expectedError))

        // Then
        XCTAssertEqual(String(describing: dispatcherMock.dispatchPassedRequests), String(describing: [ToolsRequest.deleteTool(id: .zero)]))
    }

    // MARK: - Test Helpers

    private func makeSUT(networkDispatcher: NetworkDispatcher) -> ToolsServices {
        let sut = ToolsServices(networkDispatcher: networkDispatcher)
        return sut
    }

    private func getAllToolsExpect(
        _ sut: ToolsServices,
        toCompleteWith expectedResult: Result<[ToolResponseEntity], ToolsServiceError>,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        let exp = expectation(description: "Wait for completion")
        sut.getAllTools { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedItems), .success(expectedItems)):
                XCTAssertEqual(String(describing: receivedItems), String(describing: expectedItems), file: file, line: line)
            case let (.failure(receivedError), .failure(expectedError)):
                XCTAssertEqual(receivedError, expectedError, file: file, line: line)
            default:
                XCTFail("Expected result \(expectedResult) got \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }

        wait(for: [exp], timeout: 1.0)
    }

    private func deleteToolExpect(
        _ sut: ToolsServices,
        toCompleteWith expectedResult: Result<NoEntity, ToolsServiceError>,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        let exp = expectation(description: "Wait for completion")
        sut.deleteTool(id: .zero) { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedItems), .success(expectedItems)):
                XCTAssertEqual(String(describing: receivedItems), String(describing: expectedItems), file: file, line: line)
            case let (.failure(receivedError), .failure(expectedError)):
                XCTAssertEqual(receivedError, expectedError, file: file, line: line)
            default:
                XCTFail("Expected result \(expectedResult) got \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()

        }
        wait(for: [exp], timeout: 1.0)
    }

}
