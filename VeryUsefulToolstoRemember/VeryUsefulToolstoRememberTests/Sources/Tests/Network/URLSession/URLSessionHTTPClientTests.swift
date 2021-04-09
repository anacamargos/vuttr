//
//  URLSessionHTTPClientTests.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 09/04/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import XCTest
@testable import VeryUsefulToolstoRemember

final class URLSessionHTTPClientTests: XCTestCase {
    
    func test_get_whenRequestIsInvalid_shouldReturnInvalidBaseURLError() {
        // Given
        let sut = makeSUT()
        let httpRequest = HTTPRequest(baseURL: .string(""), method: .get)
        let expectedError = NetworkError(.internal(.invalidBaseURL))
        
        // When
        guard let receivedError = resultErrorFor(networkRequest: httpRequest, sut: sut) else {
            XCTFail("Could not find receivedError")
            return
        }
        
        // Then
        XCTAssertEqual(String(describing: receivedError), String(describing: expectedError))
    }
    
    func test_get_whenHTTPResponseIsInvalid_shouldReturnInvalidHTTPResponse() {
        // Given
        let urlSessionMock = URLSessionMock()
        urlSessionMock.dataTaskResultToBeReturned = (nil, nil, nil)
        let sut = makeSUT(session: urlSessionMock)
        let httpRequest = HTTPRequest(baseURL: .string("http://a-url.com"), method: .get)
        let expectedError = NetworkError(.internal(.invalidHTTPResponse))
        
        // When
        guard let receivedError = resultErrorFor(networkRequest: httpRequest, sut: sut) else {
            XCTFail("Could not find receivedError")
            return
        }
        
        // Then
        XCTAssertEqual(String(describing: receivedError), String(describing: expectedError))
    }
    
    func test_get_whenRequestFails_shouldReturnReceivedError() {
        // Given
        let urlSessionMock = URLSessionMock()
        let nsError = NSError(domain: "", code: 400)
        urlSessionMock.dataTaskResultToBeReturned = (nil, nil, nsError)
        let sut = makeSUT(session: urlSessionMock)
        let httpRequest = HTTPRequest(baseURL: .string("http://a-url.com"), method: .get)
        let expectedError = NetworkError(requestError: .http(400), rawError: nsError)
        
        // When
        guard let receivedError = resultErrorFor(networkRequest: httpRequest, sut: sut) else {
            XCTFail("Could not find receivedError")
            return
        }
        
        // Then
        XCTAssertEqual(String(describing: receivedError), String(describing: expectedError))
    }

    // MARK: - Test Helpers
    
    private func makeSUT(
        session: URLSessionProvider = URLSessionDummy(),
        configuration: NetworkConfiguration = NetworkConfiguration(urlProvider: URLProviderDummy()),
        file: StaticString = #file,
        line: UInt = #line
    ) -> URLSessionHTTPClient {
        let sut = URLSessionHTTPClient(session: session, configuration: configuration)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
    
    private func resultFor(
        request: NetworkRequest,
        sut: URLSessionHTTPClient,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Result<NetworkResponse, NetworkError> {
         
        var receivedResult: Result<NetworkResponse, NetworkError>!
        let exp = expectation(description: "Wait for completion")
        sut.get(from: request) { result in
            receivedResult = result
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
        return receivedResult
    }
    
    private func resultErrorFor(
        networkRequest: NetworkRequest,
        sut: URLSessionHTTPClient,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Error? {
        let result = resultFor(request: networkRequest, sut: sut)
        switch result {
        case let .failure(error):
            return error
        default:
            XCTFail("Expected failure, got \(result) instead", file: file, line: line)
            return nil
        }
    }
}

final class URLSessionDummy: URLSessionProvider {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return .init()
    }
}

final class URLSessionMock: URLSessionProvider {
    
    var dataTaskResultToBeReturned: (data: Data?, response: URLResponse?, error: Error?) = (nil, nil, nil)
    private(set) var dataTaskPassedRequests = [URLRequest]()
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        dataTaskPassedRequests.append(request)
        completionHandler(dataTaskResultToBeReturned.data, dataTaskResultToBeReturned.response, dataTaskResultToBeReturned.error)
        return URLSession.shared.dataTask(with: request)
    }
}
