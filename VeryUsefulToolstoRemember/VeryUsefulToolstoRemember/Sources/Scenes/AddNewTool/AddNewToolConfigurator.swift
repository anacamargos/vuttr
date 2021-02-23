//
//  AddNewToolConfigurator.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 23/02/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import UIKit

final class AddNewToolConfigurator {
    
    func resolveViewController() -> UIViewController {
        let router = AddNewToolRouter()
        let viewController = AddNewToolViewController(router: router)
        router.viewController = viewController
        return viewController
    }
}
