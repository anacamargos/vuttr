//
//  RemoveToolConfigurator.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 09/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import UIKit

struct RemoveToolSceneParameters {
    let toolName: String
    let toolId: UInt
    weak var delegate: RemoveToolDelegate?
}

final class RemoveToolConfigurator {

    // MARK: - Public Methods

    func resolveViewController(using parameters: RemoveToolSceneParameters) -> UIViewController {
        let configuration = NetworkConfiguration(urlProvider: DefaultURLProvider())
        let networkRespondeDecoder = DefaultResponseDecoder()
        let httpClient = URLSessionHTTPClient(session: URLSession.shared, configuration: configuration)
        let networkDispatcher = DefaultNetworkDispatcher(httpClient: httpClient, responseDecoder: networkRespondeDecoder)
        let service = ToolsServices(networkDispatcher: networkDispatcher)
        let deleteToolUseCase = DeleteToolUseCase(service: service)

        let presenter = RemoveToolPresenter()
        let interactor = RemoveToolInteractor(presenter: presenter, parameters: parameters, deleteToolUseCase: deleteToolUseCase, delegate: parameters.delegate)
        let router = RemoveToolRouter()
        let viewController = RemoveToolViewController(interactor: interactor, router: router)
        router.viewController = viewController
        presenter.viewController = viewController
        viewController.modalPresentationStyle = .overFullScreen
        viewController.modalTransitionStyle = .crossDissolve
        return viewController
    }
}
