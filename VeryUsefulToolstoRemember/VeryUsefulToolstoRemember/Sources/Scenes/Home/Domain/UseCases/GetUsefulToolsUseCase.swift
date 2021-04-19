//
//  GetUsefulToolsUseCase.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 01/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation

protocol GetUsefulToolsUseCaseProvider {
    func execute(then handle: @escaping (Result<[GetUsefulToolsUseCaseModels.Tool], GetUsefulToolsUseCaseError>) -> Void)
}

final class GetUsefulToolsUseCase: GetUsefulToolsUseCaseProvider {
    
    // MARK: - Dependencies
    
    private let service: ToolsServicesProvider
    
    // MARK: - Initializer
    
    init(service: ToolsServicesProvider) {
        self.service = service
    }
    
    // MARK: - GetUsefulToolsUseCaseProvider
    
    func execute(then handle: @escaping (Result<[GetUsefulToolsUseCaseModels.Tool], GetUsefulToolsUseCaseError>) -> Void) {
        service.getAllTools { [weak self] result in
            switch result {
            case let .success(data):
                self?.handleSuccess(input: data, then: handle)
            case .failure:
                handle(.failure(.genericError))
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func handleSuccess(
        input: [ToolResponseEntity],
        then handle: @escaping (Result<[GetUsefulToolsUseCaseModels.Tool], GetUsefulToolsUseCaseError>) -> Void
    ) {
        let domainTools = input.map {
            GetUsefulToolsUseCaseModels.Tool(id: $0.id, title: $0.title, link: $0.link, description: $0.description, tags: $0.tags)
        }
        handle(.success(domainTools))
    }
}
