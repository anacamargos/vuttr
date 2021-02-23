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
        let router = HomeRouter(addNewToolConfigurator: addNewToolConfigurator)
        let viewController = HomeViewController(router: router)
        router.viewController = viewController
        return viewController
    }
}
