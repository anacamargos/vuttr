//
//  DefaultResponseDecoderTests.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 08/04/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import XCTest
@testable import VeryUsefulToolstoRemember

final class DefaultResponseDecoderTests: XCTestCase {

    func test_decodeDataRequestResult_whenResultIsSuccessWithNilData_resultingValueShouldBeNil() {
        // Given
        let sut = DefaultResponseDecoder()
        let networkResponse = NetworkResponse(status: .http(200), data: nil)
        let result: Swift.Result<NetworkResponse, NetworkError> = .success(networkResponse)

        // When
        let resultingValue = getDecodeDataRequestSuccess(
            from: sut,
            for: result
        )

        // Then
        XCTAssertNil(resultingValue)
    }

    func test_decodeDataRequestResult_whenResultIsSuccessWithValidData_resultingValueShouldBeValid() {
        // Given
        let sut = DefaultResponseDecoder()
        let jsonData = createJSONDataMock()
        let networkResponse = NetworkResponse(status: .http(200), data: jsonData)
        let result: Swift.Result<NetworkResponse, NetworkError> = .success(networkResponse)
        let expecteValue = CodableMock(key: "value")

        // When
        let resultingValue = getDecodeDataRequestSuccess(
            from: sut,
            for: result
        )

        // Then
        XCTAssertEqual(resultingValue, expecteValue)
    }

    func test_decodeDataRequestResult_whenResultIsNetworkError_resultingErrorShouldBeValid() {
        // Given
        let sut = DefaultResponseDecoder()
        let expectedError: NetworkError = .init(.internal(.unexpected))
        let result: Swift.Result<NetworkResponse, NetworkError> = .failure(expectedError)

        // When
        let resultingError = getDecodeDataRequestFailure(
            from: sut,
            for: result
        ) as NSError?

        // Then
        let expectedErrorAsNSError = expectedError as NSError
        XCTAssertEqual(resultingError, expectedErrorAsNSError)
    }

    func test_decodeDataRequestResult_whenResultIsNetworkError_resultingErrorShouldBeObjectDecoding() {
        // Given
        let sut = DefaultResponseDecoder()
        let expectedError: NetworkError = .init(.internal(.objectDecoding))
        guard let invalidJsonData = """
            {
                "key": "value
            }
            """.data(using: .utf8)
        else {
            XCTFail("Could not create jsonData.")
            return
        }
        let networkResponse = NetworkResponse(status: .http(200), data: invalidJsonData)
        let result: Swift.Result<NetworkResponse, NetworkError> = .success(networkResponse)

        // When
        let resultingError = getDecodeDataRequestFailure(
            from: sut,
            for: result
        ) as NSError?

        // Then
        let expectedErrorAsNSError = expectedError as NSError
        XCTAssertEqual(resultingError, expectedErrorAsNSError)
    }

    // MARK: - Helper Functions

    private func createJSONDataMock(file: StaticString = #file, line: UInt = #line) -> Data {
        guard let jsonData = """
            {
                "key": "value"
            }
            """.data(using: .utf8)
        else {
            XCTFail("Could not create jsonData.", file: file, line: line)
            return Data()
        }
        return jsonData
    }

    private func getDecodeDataRequestSuccess(
        from sut: DefaultResponseDecoder,
        for result: Swift.Result<NetworkResponse, NetworkError>,
        file: StaticString = #file,
        line: UInt = #line
    ) -> CodableMock? {
        var resultingValue: CodableMock?
        let decodeDataRequestResultExpectation = expectation(description: "decodeDataRequestResultExpectation")
        sut.decodeDataRequestResult(result, ofType: CodableMock.self) { result in
            switch result {
            case .failure:
                XCTFail("Expected .success but got .failure", file: file, line: line)
            case let .success(value):
                resultingValue = value
            }
            decodeDataRequestResultExpectation.fulfill()
        }
        wait(for: [decodeDataRequestResultExpectation], timeout: 1.0)
        return resultingValue
    }

    private func getDecodeDataRequestFailure(
        from sut: DefaultResponseDecoder,
        for result: Swift.Result<NetworkResponse, NetworkError>,
        file: StaticString = #file,
        line: UInt = #line
    ) -> NetworkError? {
        var resultingError: NetworkError?
        let decodeDataRequestResultExpectation = expectation(description: "decodeDataRequestResultExpectation")
        sut.decodeDataRequestResult(result, ofType: CodableMock.self) { result in
            switch result {
            case let .failure(error):
                resultingError = error
            case .success:
                XCTFail("Expected .failure but got .success", file: file, line: line)
            }
            decodeDataRequestResultExpectation.fulfill()
        }
        wait(for: [decodeDataRequestResultExpectation], timeout: 1.0)
        return resultingError
    }

}

struct CodableMock: Codable, Equatable {
    let key: String
}
