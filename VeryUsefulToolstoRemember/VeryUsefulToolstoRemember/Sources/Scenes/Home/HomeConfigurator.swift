//
//  HomeConfigurator.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 18/02/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import UIKit

final class HomeConfigurator {
    
    // MARK: - Public Methods
    
    func resolveViewController() -> UIViewController {
        let addNewToolConfigurator = AddNewToolConfigurator()
        let removeToolConfigurator = RemoveToolConfigurator()
        let getToolsUseCase = GetUsefulToolsUseCase()
        
        let presenter = HomePresenter()
        let interactor = HomeInteractor(presenter: presenter, getToolsUseCase: getToolsUseCase)
        let router = HomeRouter(addNewToolConfigurator: addNewToolConfigurator, removeToolConfigurator: removeToolConfigurator, dataStore: interactor)
        let viewController = HomeViewController(interactor: interactor, router: router)
        router.viewController = viewController
        presenter.viewController = viewController
        return viewController
    }
}
