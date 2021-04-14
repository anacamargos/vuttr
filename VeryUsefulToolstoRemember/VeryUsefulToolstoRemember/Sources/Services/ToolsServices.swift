//
//  ToolsServices.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 14/04/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation

protocol ToolsServicesProvider {
    func getAllTools(then handle: @escaping (Result<NetworkResponse, NetworkError>) -> Void)
}

final class ToolsServices: ToolsServicesProvider {
    
    // MARK: - Dependencies
    
    private let networkDispatcher: NetworkDispatcher
    
    // MARK: - Initializers
    
    init(networkDispatcher: NetworkDispatcher) {
        self.networkDispatcher = networkDispatcher
    }
    
    // MARK: - ToolsServicesProvider
    
    func getAllTools(then handle: @escaping (Result<NetworkResponse, NetworkError>) -> Void) {
        
    }
}
