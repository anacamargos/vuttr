//
//  HomeInteractor.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 25/02/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation

protocol HomeBusinessLogic {
    func onViewDidLoad()
}

final class HomeInteractor {
    
    // MARK: - Dependencies
    
    private let presenter: HomePresentationLogic
    private let getToolsUseCase: GetUsefulToolsUseCaseProvider
    
    // MARK: - Initializer
    
    init(
        presenter: HomePresentationLogic,
        getToolsUseCase: GetUsefulToolsUseCaseProvider
    ) {
        self.presenter = presenter
        self.getToolsUseCase = getToolsUseCase
    }
}

// MARK: - HomeBusinessLogic

extension HomeInteractor: HomeBusinessLogic {
    
    func onViewDidLoad() {
        presenter.presentToolsResponse(.loading)
        getToolsUseCase.execute { [weak self] result in
            switch result {
            case let .success(data):
                self?.presenter.presentToolsResponse(.content(data))
            case .failure:
                self?.presenter.presentToolsResponse(.error)
            }
        }
    }
}
