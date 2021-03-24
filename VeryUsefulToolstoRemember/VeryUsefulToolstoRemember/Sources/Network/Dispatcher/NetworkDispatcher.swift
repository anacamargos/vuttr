//
//  NetworkDispatcher.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 24/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation

protocol NetworkDispatcher {
    
    /// Dispatches a request and returns the value as data
    /// - Parameters:
    ///   - request: a request object
    ///   - then: the request result closure
    func dispatch(
        _ request: NetworkRequest,
        onQueue queue: DispatchQueue,
        then handle: @escaping (Result<NetworkResponse, NetworkError>) -> Void
    )

    /// Dispatches a request and returns the value as the especified type
    /// - Parameters:
    ///   - type: the type of the object you want
    ///   - request: a request object
    ///   - then: the request result closure
    func requestCodable<T: Codable>(
        ofType type: T.Type,
        for request: NetworkRequest,
        onQueue queue: DispatchQueue,
        then handle: @escaping (Result<T?, NetworkError>) -> Void
    )
}

extension NetworkDispatcher {
    func dispatch(
        _ request: NetworkRequest,
        onQueue queue: DispatchQueue = .main,
        then handle: @escaping (Result<NetworkResponse, NetworkError>) -> Void
    ) {
        dispatch(request, onQueue: queue, then: handle)
    }

    func requestCodable<T: Codable>(
        ofType type: T.Type,
        for request: NetworkRequest,
        onQueue queue: DispatchQueue = .main,
        then handle: @escaping (Result<T?, NetworkError>) -> Void
    ) {
        requestCodable(ofType: type, for: request, onQueue: queue, then: handle)
    }
}
