//
//  CreateNewToolUseCase.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 04/05/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation

enum CreateNewToolUseCaseError: Error {
    case genericError
}

protocol CreateNewToolUseCaseProvider {
    func execute(parameters: CreateNewToolParameters, then handle: @escaping (Result<GetUsefulToolsUseCaseModels.Tool, CreateNewToolUseCaseError>) -> Void)
}

final class CreateNewToolUseCase: CreateNewToolUseCaseProvider {

    // MARK: - Dependencies

    private let service: ToolsServicesProvider

    // MARK: - Initializer

    init(service: ToolsServicesProvider) {
        self.service = service
    }

    // MARK: - CreateNewToolUseCaseProvider

    func execute(parameters: CreateNewToolParameters, then handle: @escaping (Result<GetUsefulToolsUseCaseModels.Tool, CreateNewToolUseCaseError>) -> Void) {
        service.createNewTool(parameters: parameters) { [weak self] result in
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
        input: ToolResponseEntity,
        then handle: @escaping (Result<GetUsefulToolsUseCaseModels.Tool, CreateNewToolUseCaseError>) -> Void
    ) {
        let domainTools = GetUsefulToolsUseCaseModels.Tool(id: input.id, title: input.title, link: input.link, description: input.description, tags: input.tags)
        handle(.success(domainTools))
    }
}
