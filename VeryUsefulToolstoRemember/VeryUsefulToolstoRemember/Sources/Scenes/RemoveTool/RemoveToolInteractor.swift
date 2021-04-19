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
}

final class RemoveToolInteractor {

    // MARK: - Dependencies

    private let presenter: RemoveToolPresentationLogic
    private let parameters: RemoveToolSceneParameters

    // MARK: - Initializer

    init(
        presenter: RemoveToolPresentationLogic,
        parameters: RemoveToolSceneParameters
    ) {
        self.presenter = presenter
        self.parameters = parameters
    }
}

// MARK: - RemoveToolBusinessLogic

extension RemoveToolInteractor: RemoveToolBusinessLogic {

    func onViewDidLoad() {
        presenter.presentToolName(parameters.toolName)
    }
}
