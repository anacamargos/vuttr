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
    func handleToolSelection(at row: Int)
}

final class HomeInteractor {
    
    // MARK: - Properties
    
    private var usefulTools: [GetUsefulToolsUseCaseModels.Tool] = []
    
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
    
    // MARK: - Private Methods
    
    private func loadTools() {
        presenter.presentToolsResponse(.loading)
        getToolsUseCase.execute { [weak self] result in
            switch result {
            case let .success(data):
                self?.usefulTools = data
                self?.presenter.presentToolsResponse(.content(data))
            case .failure:
                self?.presenter.presentToolsResponse(.error)
            }
        }
    }
}

// MARK: - HomeBusinessLogic

extension HomeInteractor: HomeBusinessLogic {
    
    func onViewDidLoad() {
        loadTools()
    }
    
    func handleToolSelection(at row: Int) {
        guard usefulTools.indices.contains(row) else { return }
        let selectedTool = usefulTools[row]
        guard let url = URL(string: selectedTool.link) else { return }
        presenter.presentURL(url)
    }
}
