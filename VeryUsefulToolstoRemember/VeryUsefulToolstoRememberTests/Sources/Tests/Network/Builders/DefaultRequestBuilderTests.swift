//
//  DefaultRequestBuilderTests.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 07/04/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import XCTest
@testable import VeryUsefulToolstoRemember

final class DefaultRequestBuilderTests: XCTestCase {
    
    // MARK: - Properties
    
    private lazy var networkConfiguration: NetworkConfiguration = {
        .init(urlProvider: URLProviderDummy())
    }()
    
    // MARK: - Tests

    func test_whenBaseURL_isInvalid_invalidBaseURLError_shouldBeThrown() {
        // Given
        let request = HTTPRequest(baseURL: .string(""), method: .get)
        let sut = DefaultRequestBuilder(
            request: request,
            networkConfiguration: networkConfiguration
        )

        // When
        var errorThrown: RequestError.Internal?
        do {
            _ = try sut.build()
        } catch {
            errorThrown = error as? RequestError.Internal
        }

        // Then
        XCTAssertNotNil(errorThrown)
        XCTAssertEqual(errorThrown?.rawValue, RequestError.Internal.invalidBaseURL.rawValue)
    }
    
    func test_whenBaseURL_isFromServiceGroup_urlProviderShouldBeCalled() {
        // Given
        let urlProviderSpy = URLProviderSpy()
        let networkConfiguration = NetworkConfiguration(
            urlProvider: urlProviderSpy
        )
        let serviceGroup: ServiceGroup = .vuttr
        let request = HTTPRequest(baseURL: .serviceGroup(serviceGroup), method: .get)
        let sut = DefaultRequestBuilder(
            request: request,
            networkConfiguration: networkConfiguration
        )

        // When
        let urlRequest = try? sut.build()

        // Then
        XCTAssertNotNil(urlRequest)
        XCTAssertEqual(String(describing: urlProviderSpy.getBaseURLPassedServiceGroups), String(describing: [serviceGroup]))
    }
    
    func test_requestWithNoHeadersOrParameters_shouldBeBuiltSuccessfuly() {
        // Given
        let request = HTTPRequest(
            baseURL: .string("www.test.com"),
            path: "/test",
            method: .get,
            timeout: 10
        )
        let sut = DefaultRequestBuilder(
            request: request,
            networkConfiguration: networkConfiguration
        )

        let expectedURL = URL(string: "www.test.com/test")

        // When
        guard let urlRequest = try? sut.build() else {
            XCTFail("RequestBuilder failed.")
            return
        }

        // Then
        XCTAssertEqual(urlRequest.url, expectedURL)
        XCTAssertEqual(urlRequest.httpMethod, request.method.name)
        XCTAssertEqual(urlRequest.timeoutInterval, request.timeout)
    }
    
    func test_request_shouldSetupCustomAndDefaultHeadersCorrectly() {
        // Given
        let request = HTTPRequest(
            baseURL: .string("www.test.com"),
            method: .get,
            headers: ["NewHeader": "NewHeader"]
        )
        let sut = DefaultRequestBuilder(
            request: request,
            networkConfiguration: networkConfiguration
        )

        // When
        guard let urlRequest = try? sut.build() else {
            XCTFail("RequestBuilder failed.")
            return
        }

        // Then
        XCTAssertEqual(urlRequest.allHTTPHeaderFields?["NewHeader"], "NewHeader")
    }
    
    func test_whenHTTPBodyIsData_requestShouldContainCorrectHTTPBody_andJSONCharsetUTF8Header() {
        // Given
        let httpBodyData = Data()
        let request = HTTPRequest(
            baseURL: .string("www.test.com"),
            method: .get,
            httpBody: .data(httpBodyData),
            headers: [Header.Key.contentType: Header.ContentType.applicationJSON]
        )
        let sut = DefaultRequestBuilder(
            request: request,
            networkConfiguration: networkConfiguration
        )

        // When
        guard let urlRequest = try? sut.build()  else {
            XCTFail("RequestBuilder failed.")
            return
        }

        // Then
        XCTAssertEqual(urlRequest.httpBody, httpBodyData)
        XCTAssertEqual(urlRequest.allHTTPHeaderFields?[Header.Key.contentType], Header.ContentType.applicationJSONCharsetUTF8)
    }
    
    func test_whenHTTPBodyIsDictionary_builderShouldSetupBodyParametersCorrectly() {
        // Given
        let request = HTTPRequest(
            baseURL: .string("www.test.com"),
            method: .get,
            httpBody: .dictionary(["value":  "data", "otherValue": "other"])
        )
        let sut = DefaultRequestBuilder(
            request: request,
            networkConfiguration: networkConfiguration
        )

        // When
        guard let urlRequest = try? sut.build()  else {
            XCTFail("RequestBuilder failed.")
            return
        }

        // Then
        guard
            let httpBodyData = urlRequest.httpBody,
            let httpBodyJSON = try? JSONSerialization.jsonObject(with: httpBodyData, options: .allowFragments) as? [String: Any]
        else {
            XCTFail("Could not extract httpBody from request.")
            return
        }

        guard case let .dictionary(httpBodyDictionary) = request.httpBody else {
            XCTFail("Invalid HTTPBody type.")
            return
        }
        let urlRequestBody = httpBodyJSON.mapValues { $0 as? String }
        let originalRequestBody = httpBodyDictionary.mapValues { $0 as? String }
        XCTAssertEqual(urlRequestBody, originalRequestBody)
        let jsonCharsetHeader = urlRequest.allHTTPHeaderFields?[Header.Key.contentType]
        XCTAssertEqual(jsonCharsetHeader, Header.ContentType.applicationJSONCharsetUTF8)
    }
    
    func test_whenHTTPBodyIsJSON_builderShouldSetupBodyParametersWithEncoding() {
        // Given
        let request = HTTPRequest(
            baseURL: .string("www.test.com"),
            method: .get,
            httpBody: .json(["value":  "data", "otherValue": "other"])
        )
        let sut = DefaultRequestBuilder(
            request: request,
            networkConfiguration: networkConfiguration
        )

        // When
        guard let urlRequest = try? sut.build()  else {
            XCTFail("RequestBuilder failed.")
            return
        }

        // Then
        guard
            let httpBodyData = urlRequest.httpBody,
            let httpBodyJSON = try? JSONSerialization.jsonObject(with: httpBodyData, options: .allowFragments) as? [String: Any]
        else {
            XCTFail("Could not extract httpBody from request.")
            return
        }

        guard case let .json(requestBodyValues) = request.httpBody else {
            XCTFail("Invalid HTTPBody type.")
            return
        }
        let urlRequestBody = httpBodyJSON.mapValues { $0 as? String }
        let originalRequestBody = (requestBodyValues as? [String: Any])?.mapValues { $0 as? String }
        XCTAssertEqual(urlRequestBody, originalRequestBody)
        let jsonCharsetHeader = urlRequest.allHTTPHeaderFields?[Header.Key.contentType]
        XCTAssertEqual(jsonCharsetHeader, Header.ContentType.applicationJSONCharsetUTF8)
    }
    
    func test_whenURLParametersIsRaw_builderShouldSetupURLParametersCorrectly() {
        // Given'
        let urlParameters = ["value":  "data", "otherValue": "other"]
        let request = HTTPRequest(
            baseURL: .string("www.test.com"),
            method: .get,
            urlParameters: .raw(urlParameters)
        )
        let sut = DefaultRequestBuilder(
            request: request,
            networkConfiguration: networkConfiguration
        )

        // When
        guard let urlRequest = try? sut.build()  else {
            XCTFail("RequestBuilder failed.")
            return
        }

        // Then
        guard
            let url = urlRequest.url,
            let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: true)?.queryItems
        else {
            XCTFail("Could not extract queryItems from request.")
            return
        }

        let queryItemValues = queryItems.map { $0.value }
        let urlParameterValues = urlParameters.map { $0.value }
        XCTAssertEqual(queryItemValues, urlParameterValues)

        let queryItemKeys = queryItems.map { $0.name }
        let urlParameterKeys = urlParameters.map { $0.key }
        XCTAssertEqual(queryItemKeys, urlParameterKeys)
    }
}
