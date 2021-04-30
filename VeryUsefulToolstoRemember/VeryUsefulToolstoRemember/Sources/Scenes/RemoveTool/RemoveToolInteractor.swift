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
    weak var delegate: RemoveToolDelegate?

    // MARK: - Initializer

    init(
        presenter: RemoveToolPresentationLogic,
        parameters: RemoveToolSceneParameters,
        deleteToolUseCase: DeleteToolUseCaseProvider,
        delegate: RemoveToolDelegate?
    ) {
        self.presenter = presenter
        self.parameters = parameters
        self.deleteToolUseCase = deleteToolUseCase
        self.delegate = delegate
    }
}

// MARK: - RemoveToolBusinessLogic

extension RemoveToolInteractor: RemoveToolBusinessLogic {

    func onViewDidLoad() {
        presenter.presentToolName(parameters.toolName)
    }

    func handleRemoveToolAction() {
        presenter.presentRemoveToolResponse(.loading)
        deleteToolUseCase.execute(toolId: parameters.toolId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.presenter.presentRemoveToolResponse(.success)
                self.delegate?.handleToolDeletion(toolId: self.parameters.toolId)
            case .failure:
                self.presenter.presentRemoveToolResponse(.error)
            }
        }
    }
}
