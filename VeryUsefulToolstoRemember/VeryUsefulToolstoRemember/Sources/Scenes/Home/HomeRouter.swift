//
//  HomeRouter.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 18/02/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import UIKit
import SafariServices

protocol HomeRoutingLogic {
    func routeToRemoveToolScene()
    func routeToAddNewToolScene()
    func routeToURL(_ url: URL)
}

protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get set }
}

final class HomeRouter: HomeRoutingLogic, HomeDataPassing {

    // MARK: - Dependencies

    weak var viewController: UIViewController?
    private let addNewToolConfigurator: AddNewToolConfigurator
    private let removeToolConfigurator: RemoveToolConfigurator
    var dataStore: HomeDataStore?

    // MARK: - Initializer

    init(
        addNewToolConfigurator: AddNewToolConfigurator,
        removeToolConfigurator: RemoveToolConfigurator,
        dataStore: HomeDataStore
    ) {
        self.addNewToolConfigurator = addNewToolConfigurator
        self.removeToolConfigurator = removeToolConfigurator
        self.dataStore = dataStore
    }

    // MARK: - Public Methods

    func routeToAddNewToolScene() {
        let delegate = dataStore as? AddNewToolDelegate
        let destinationViewController = addNewToolConfigurator.resolveViewController(using: .init(delegate: delegate))
        viewController?.present(destinationViewController, animated: true)
    }

    func routeToURL(_ url: URL) {
        let destinationViewController = SFSafariViewController(url: url)
        viewController?.present(destinationViewController, animated: true)
    }

    func routeToRemoveToolScene() {
        guard let selectedTool = dataStore?.selectedTool else { return }
        var parameters = RemoveToolSceneParameters(toolName: selectedTool.title, toolId: selectedTool.id)
        parameters.delegate = dataStore as? RemoveToolDelegate
        let destinationViewController = removeToolConfigurator.resolveViewController(using: parameters)
        viewController?.present(destinationViewController, animated: true)
    }
}
