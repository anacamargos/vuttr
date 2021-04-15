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
        expect(sut, toCompleteWith: .failure(expectedError))
        
        // Then
        XCTAssertEqual(String(describing: dispatcherMock.requestCodablePassedRequests), String(describing: [ToolsRequest.getTools]))
    }

    // MARK: - Test Helpers
    
    private func makeSUT(networkDispatcher: NetworkDispatcher) -> ToolsServices {
        let sut = ToolsServices(networkDispatcher: networkDispatcher)
        return sut
    }
    
    private func expect(
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
    
}

final class NetworkDispatcherDummy: NetworkDispatcher {
    func dispatch(_ request: NetworkRequest, then handle: @escaping (Result<NetworkResponse, NetworkError>) -> Void) {}
    func requestCodable<T>(ofType type: T.Type, for request: NetworkRequest, then handle: @escaping (Result<T?, NetworkError>) -> Void) where T : Decodable, T : Encodable {}
}

final class NetworkDispatcherMock<T: Codable>: NetworkDispatcher {
    
    var dispatchResultToBeReturned: Result<NetworkResponse, NetworkError> = .success(.init(status: .http(200), data: nil))
    private(set) var dispatchPassedRequests = [NetworkRequest]()
    
    func dispatch(_ request: NetworkRequest, then handle: @escaping (Result<NetworkResponse, NetworkError>) -> Void) {
        dispatchPassedRequests.append(request)
        handle(dispatchResultToBeReturned)
    }
    
    var requestCodableResultToBeReturned: Result<T?, NetworkError> = .success(nil)
    private(set) var requestCodablePassedRequests = [NetworkRequest]()
    
    func requestCodable<T>(ofType type: T.Type, for request: NetworkRequest, then handle: @escaping (Result<T?, NetworkError>) -> Void) where T : Decodable, T : Encodable {
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
