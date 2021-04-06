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
}
