//
//  AddNewToolRouter.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 23/02/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import UIKit

protocol AddNewToolRoutingLogic {
    func routeToPreviousScene()
}

final class AddNewToolRouter: AddNewToolRoutingLogic {
    
    // MARK: - Dependencies
    
    weak var viewController: UIViewController?
    
    // MARK: - Public Methods
    
    func routeToPreviousScene() {
        viewController?.dismiss(animated: true)
    }
    
}
