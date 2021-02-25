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
    
    // MARK: - Initializer
    
    init(presenter: HomePresentationLogic) {
        self.presenter = presenter
    }
}

// MARK: - HomeBusinessLogic

extension HomeInteractor: HomeBusinessLogic {
    
    func onViewDidLoad() {
        presenter.presentToolsViewState()
    }
}
