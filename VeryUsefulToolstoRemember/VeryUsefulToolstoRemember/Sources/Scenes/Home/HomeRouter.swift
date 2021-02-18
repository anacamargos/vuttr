//
//  HomeRouter.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 18/02/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import UIKit

protocol HomeRoutingLogic{
    func routeToAddNewToolScene()
}

final class HomeRouter: HomeRoutingLogic{
    
    // MARK: - Dependencies
    
    weak var viewController: UIViewController?
    
    // MARK: - Public Methods
    
    func routeToAddNewToolScene() {
        let destinationViewController = AddNewToolViewController()
        destinationViewController.modalPresentationStyle = .overFullScreen
        destinationViewController.modalTransitionStyle = .crossDissolve
        viewController?.present(destinationViewController, animated: true)
    }
}
