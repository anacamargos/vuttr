//
//  RemoveToolRouter.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 09/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import UIKit

protocol RemoveToolRoutingLogic {
    func routeToPreviousScene()
}

final class RemoveToolRouter: RemoveToolRoutingLogic {

    // MARK: - Dependencies

    weak var viewController: UIViewController?

    // MARK: - Public Methods

    func routeToPreviousScene() {
        viewController?.dismiss(animated: true)
    }
}
