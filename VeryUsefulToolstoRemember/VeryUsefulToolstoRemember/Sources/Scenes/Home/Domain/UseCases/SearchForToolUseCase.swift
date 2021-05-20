//
//  SearchForToolUseCase.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 20/05/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation

protocol SearchForToolUseCaseProvider {
    func execute(request: SearchForToolUseCaseModels.Request, then handle: @escaping (Result<[GetUsefulToolsUseCaseModels.Tool], SearchForToolUseCaseError>) -> Void)
}

final class SearchForToolUseCase: SearchForToolUseCaseProvider {

    // MARK: - Dependencies

    private let service: ToolsServicesProvider

    // MARK: - Initializer

    init(service: ToolsServicesProvider) {
        self.service = service
    }

    // MARK: - SearchForToolUseCaseProvider

    func execute(request: SearchForToolUseCaseModels.Request, then handle: @escaping (Result<[GetUsefulToolsUseCaseModels.Tool], SearchForToolUseCaseError>) -> Void) {
        let parameters = SearchToolParameters(text: request.text)
        service.searchForTool(parameters: parameters) { [weak self] result in
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
        then handle: @escaping (Result<[GetUsefulToolsUseCaseModels.Tool], SearchForToolUseCaseError>) -> Void
    ) {
        let domainTools = input.map {
            GetUsefulToolsUseCaseModels.Tool(id: $0.id, title: $0.title, link: $0.link, description: $0.description, tags: $0.tags)
        }
        handle(.success(domainTools))
    }
}
