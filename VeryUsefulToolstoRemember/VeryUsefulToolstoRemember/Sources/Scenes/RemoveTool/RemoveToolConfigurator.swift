//
//  RemoveToolConfigurator.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 09/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import UIKit

struct RemoveToolSceneParameters {
    let toolName: String
    let toolId: Int
}

final class RemoveToolConfigurator {
    
    // MARK: - Public Methods
    
    func resolveViewController(using parameters: RemoveToolSceneParameters) -> UIViewController {
        let presenter = RemoveToolPresenter()
        let interactor = RemoveToolInteractor(presenter: presenter, parameters: parameters)
        let router = RemoveToolRouter()
        let viewController = RemoveToolViewController(interactor: interactor, router: router)
        router.viewController = viewController
        presenter.viewController = viewController
        return viewController
    }
}
