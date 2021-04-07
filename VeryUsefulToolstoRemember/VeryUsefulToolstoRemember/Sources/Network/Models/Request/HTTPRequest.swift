//
//  HTTPRequest.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 07/04/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation

struct HTTPRequest: NetworkRequest {
    var baseURL: BaseURL
    var path: String?
    var method: HTTPMethod
    var urlParameters: URLParameters?
    var httpBody: HTTPBody?
    var headers: [String: String]
    var timeout: Double?
    
    init(
        baseURL: BaseURL,
        path: String? = nil,
        method: HTTPMethod,
        urlParameters: URLParameters? = nil,
        httpBody: HTTPBody? = nil,
        headers: [String: String] = [:],
        timeout: Double? = nil
    ) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.urlParameters = urlParameters
        self.httpBody = httpBody
        self.headers = headers
        self.timeout = timeout
    }
}
