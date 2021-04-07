//
//  DefaultRequestBuilder.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 05/04/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation

final class DefaultRequestBuilder: NetworkRequestBuilder {
    
    // MARK: - Properties
    
    private let networkConfiguration: NetworkConfiguration
    private var baseURL: BaseURL
    private var path: String?
    private var method: HTTPMethod
    private var urlParameters: URLParameters?
    private var httpBody: HTTPBody?
    private var headers: [String: String]
    private var timeout: Double?
    
    // MARK: - Initializer
    
    init(
        request: NetworkRequest,
        networkConfiguration: NetworkConfiguration
    ) {
        baseURL = request.baseURL
        path = request.path
        method = request.method
        urlParameters = request.urlParameters
        httpBody = request.httpBody
        headers = request.headers
        timeout = request.timeout
        self.networkConfiguration = networkConfiguration
    }
    
    // MARK: - NetworkRequestBuilder
    
    func build() throws -> URLRequest {
        var url = try getURL(baseURL: baseURL)
        if let path = path {
            url = url.appendingPathComponent(path)
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        if let timeout = timeout {
            urlRequest.timeoutInterval = timeout
        }
        setupRequestHeaders(for: &urlRequest)
        setupHTTPBody(for: &urlRequest)
        setupURLParameters(for: &urlRequest)
        return urlRequest
    }
    
    // MARK: - Private Methods
    
    private func getURL(
        baseURL: BaseURL
    ) throws -> URL {
        var baseURLString: String
        switch baseURL {
        case let .string(urlString):
            baseURLString = urlString
        case let .serviceGroup(serviceGroup):
            let urlProvider = networkConfiguration.urlProvider
            baseURLString = urlProvider.getBaseURL(forServiceGroup: serviceGroup)
        }
        guard let url = URL(string: baseURLString) else {
            throw RequestError.Internal.invalidBaseURL
        }
        return url
    }
    
    private func setupRequestHeaders(
        for request: inout URLRequest
    ) {
        headers.forEach { header in
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
    }
    
    private func setupHTTPBody(for request: inout URLRequest) {
        if let httpBody = httpBody {
            configureHTTPBody(httpBody, for: &request)
        }
    }
    
    private func configureHTTPBody(
        _ httpBody: HTTPBody,
        for request: inout URLRequest
    ) {
        let contentType = Header.ContentType.applicationJSONCharsetUTF8
        switch httpBody {
        case let .data(data):
            request.httpBody = data
        case let .dictionary(dictionary):
            configureHTTPBodyWithJSON(dictionary, for: &request)
        case let .json(json):
            configureHTTPBodyWithJSON(json, for: &request)
        }
        request.setValue(contentType, forHTTPHeaderField: Header.Key.contentType)
    }
    
    private func configureHTTPBodyWithJSON(
        _ json: Any,
        for request: inout URLRequest
    ) {
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        request.httpBody = jsonData
    }
    
    private func setupURLParameters(for request: inout URLRequest) {
        if let urlParameters = urlParameters {
            configureURLParameters(urlParameters, for: &request)
        }
    }
    
    private func configureURLParameters(_ parameters: URLParameters, for request: inout URLRequest) {
        switch parameters {
        case let .raw(parameters):
            setupRawURLParameteres(parameters, for: &request)
        }
    }
    
    private func setupRawURLParameteres(_ parameters: [String: String], for request: inout URLRequest) {
        if let url = request.url, var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) {
            urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
            request.url = urlComponents.url
        }
    }
}
