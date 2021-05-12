//
//  AddNewToolInteractor.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 05/05/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation

protocol AddNewToolBusinessLogic {
    func handleNewToolCreation(_ request: AddNewTool.Request)
}

final class AddNewToolInteractor {

    // MARK: - Dependencies

    private let presenter: AddNewToolPresentationLogic
    private let createNewToolUseCase: CreateNewToolUseCaseProvider
    weak var delegate: AddNewToolDelegate?

    // MARK: - Initializer

    init(
        presenter: AddNewToolPresentationLogic,
        createNewToolUseCase: CreateNewToolUseCaseProvider,
        delegate: AddNewToolDelegate?
    ) {
        self.presenter = presenter
        self.createNewToolUseCase = createNewToolUseCase
        self.delegate = delegate
    }
}

// MARK: - AddNewToolBusinessLogic

extension AddNewToolInteractor: AddNewToolBusinessLogic {

    func handleNewToolCreation(_ request: AddNewTool.Request) {
        presenter.presentToolsResponse(.loading)
        createNewToolUseCase.execute(request: request) { [weak self] result in
            switch result {
            case let .success(response):
                self?.presenter.presentToolsResponse(.success)
                self?.delegate?.handleToolCreation(response)
            case .failure:
                self?.presenter.presentToolsResponse(.error)
            }
        }
    }
}
