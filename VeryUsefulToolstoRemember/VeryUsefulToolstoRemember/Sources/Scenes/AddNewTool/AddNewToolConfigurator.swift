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
        let urlProvider = DefaultURLProvider()
        let networkConfiguration = NetworkConfiguration(urlProvider: urlProvider)
        let responseDecoder = DefaultResponseDecoder()
        let httpClient = URLSessionHTTPClient(session: URLSession.shared, configuration: networkConfiguration)
        let networkDispatcher = DefaultNetworkDispatcher(httpClient: httpClient, responseDecoder: responseDecoder)
        let service = ToolsServices(networkDispatcher: networkDispatcher)

        let createNewToolUseCase = CreateNewToolUseCase(service: service)
        let presenter = AddNewToolPresenter()
        let interactor = AddNewToolInteractor(presenter: presenter, createNewToolUseCase: createNewToolUseCase)

        let router = AddNewToolRouter()
        let viewController = AddNewToolViewController(interactor: interactor, router: router)
        router.viewController = viewController
        presenter.viewController = viewController
        viewController.modalPresentationStyle = .overFullScreen
        viewController.modalTransitionStyle = .crossDissolve
        return viewController
    }
}
