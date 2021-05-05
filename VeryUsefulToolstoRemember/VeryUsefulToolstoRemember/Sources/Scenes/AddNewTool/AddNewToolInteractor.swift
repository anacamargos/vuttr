//
//  AddNewToolInteractor.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 05/05/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation

final class AddNewToolInteractor {
    
    // MARK: - Dependencies

    private let presenter: AddNewToolPresentationLogic
    private let createNewToolUseCase: CreateNewToolUseCaseProvider
    
    // MARK: - Initializer

    init(
        presenter: AddNewToolPresentationLogic,
        createNewToolUseCase: CreateNewToolUseCaseProvider
    ) {
        self.presenter = presenter
        self.createNewToolUseCase = createNewToolUseCase
    }
}
