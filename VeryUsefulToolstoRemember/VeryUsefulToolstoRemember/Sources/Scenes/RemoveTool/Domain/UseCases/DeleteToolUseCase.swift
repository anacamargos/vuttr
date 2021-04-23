//
//  DeleteToolUseCase.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 23/04/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation

enum DeleteToolUseCaseError: Error {
    case genericError
}

protocol DeleteToolUseCaseProvider {
    func execute(toolId: UInt, then handle: @escaping (Result<NoEntity, DeleteToolUseCaseError>) -> Void)
}

final class DeleteToolUseCase: DeleteToolUseCaseProvider {

    // MARK: - Dependencies

    private let service: ToolsServicesProvider

    // MARK: - Initializer

    init(service: ToolsServicesProvider) {
        self.service = service
    }

    // MARK: - DeleteToolUseCaseProvider

    func execute(toolId: UInt, then handle: @escaping (Result<NoEntity, DeleteToolUseCaseError>) -> Void) {
        service.deleteTool(id: toolId) { result in
            switch result {
            case .success:
                handle(.success(.init()))
            case .failure:
                handle(.failure(.genericError))
            }
        }
    }
}
