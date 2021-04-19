//
//  NetworkRequest.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 24/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation

/// Defines the Request protocol, which can be implemented as a class, struct or enum.
protocol NetworkRequest {

    // MARK: - Properties

    /// The API's base url.
    var baseURL: BaseURL { get }

    /// Defines the endpoint we want to hit.
    var path: String? { get }

    /// Parameters we want to pass with the request that needds to be appendend to the URL.
    var urlParameters: URLParameters? { get }

    /// Relative to the method we want to call, which was defined with an enum above.
    var method: HTTPMethod { get }

    /// Parameters we want to pass with the request that can be used for the body or the URL.
    var httpBody: HTTPBody? { get }

    /// Defines the list of headers we want to pass along with each request.
    var headers: [String: String] { get }

    /// Defines the timeout for the request
    var timeout: Double? { get }
}

extension NetworkRequest {
    /// queryParameters default value
    var urlParameters: URLParameters? { nil }

    /// httpBody default value
    var httpBody: HTTPBody? { nil }

    /// headers default value
    var headers: [String: String] { [:] }

    /// request default timeout
    var timeout: Double? { nil }
}
