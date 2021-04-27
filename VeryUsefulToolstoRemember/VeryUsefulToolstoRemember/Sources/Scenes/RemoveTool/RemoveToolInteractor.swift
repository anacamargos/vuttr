//
//  RemoveToolInteractor.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 09/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation

protocol RemoveToolBusinessLogic {
    func onViewDidLoad()
    func handleRemoveToolAction()
}

final class RemoveToolInteractor {

    // MARK: - Dependencies

    private let presenter: RemoveToolPresentationLogic
    private let parameters: RemoveToolSceneParameters
    private let deleteToolUseCase: DeleteToolUseCaseProvider

    // MARK: - Initializer

    init(
        presenter: RemoveToolPresentationLogic,
        parameters: RemoveToolSceneParameters,
        deleteToolUseCase: DeleteToolUseCaseProvider
    ) {
        self.presenter = presenter
        self.parameters = parameters
        self.deleteToolUseCase = deleteToolUseCase
    }
}

// MARK: - RemoveToolBusinessLogic

extension RemoveToolInteractor: RemoveToolBusinessLogic {

    func onViewDidLoad() {
        presenter.presentToolName(parameters.toolName)
    }

    func handleRemoveToolAction() {
        deleteToolUseCase.execute(toolId: parameters.toolId) { _ in

        }
    }
}
