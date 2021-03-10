//
//  RemoveToolConfigurator.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 09/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import UIKit

final class RemoveToolConfigurator {
    
    // MARK: - Public Methods
    
    func resolveViewController() -> UIViewController {
        let presenter = RemoveToolPresenter()
        let interactor = RemoveToolInteractor(presenter: presenter)
        let router = RemoveToolRouter()
        let viewController = RemoveToolViewController(interactor: interactor, router: router)
        router.viewController = viewController
        presenter.viewController = viewController
        return viewController
    }
}
