//
//  NetworkRequestBuilder.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 03/04/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation

protocol NetworkRequestBuilder {

    // MARK: - Initialization

    /// Intitializes a builder
    /// - Parameters:
    ///   - request: the NetworkRequest to init the builder
    ///   - networkConfiguration: configuration parameters
    init(
        request: NetworkRequest,
        networkConfiguration: NetworkConfiguration
    )

    /// Builds an URLRequest as previously defined.
    ///
    /// - Returns: A configured URLRequest.
    func build() throws -> URLRequest
}
