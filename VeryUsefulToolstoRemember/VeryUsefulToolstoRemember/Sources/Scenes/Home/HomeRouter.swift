//
//  HomeRouter.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 18/02/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import UIKit
import SafariServices

protocol HomeRoutingLogic{
    func routeToAddNewToolScene()
    func routeToURL(_ url: URL)
}

final class HomeRouter: HomeRoutingLogic{
    
    // MARK: - Dependencies
    
    weak var viewController: UIViewController?
    private let addNewToolConfigurator: AddNewToolConfigurator
    
    // MARK: - Initializer
    
    init(addNewToolConfigurator: AddNewToolConfigurator) {
        self.addNewToolConfigurator = addNewToolConfigurator
    }
    
    // MARK: - Public Methods
    
    func routeToAddNewToolScene() {
        let destinationViewController = addNewToolConfigurator.resolveViewController()
        viewController?.present(destinationViewController, animated: true)
    }
    
    func routeToURL(_ url: URL) {
        let destinationViewController = SFSafariViewController(url: url)
        viewController?.present(destinationViewController, animated: true)
    }
}
