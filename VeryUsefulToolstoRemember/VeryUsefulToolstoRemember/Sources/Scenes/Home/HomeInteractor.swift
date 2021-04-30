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
    func reloadTools()
    func handleToolSelection(at row: Int)
    func handleRemoveToolSelection(_ toolId: UInt)
}

protocol HomeDataStore {
    var selectedTool: GetUsefulToolsUseCaseModels.Tool? { get set }
}

protocol RemoveToolDelegate: AnyObject {
    func handleToolDeletion(toolId: UInt)
}

final class HomeInteractor: HomeDataStore {

    // MARK: - Properties

    private var usefulTools: [GetUsefulToolsUseCaseModels.Tool] = []
    var selectedTool: GetUsefulToolsUseCaseModels.Tool?

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
                self?.updateUsefulTools()
            case .failure:
                self?.presenter.presentToolsResponse(.error)
            }
        }
    }

    private func updateUsefulTools() {
        if usefulTools.isEmpty {
            presenter.presentToolsResponse(.empty)
        } else {
            presenter.presentToolsResponse(.content(usefulTools))
        }
    }
}

// MARK: - HomeBusinessLogic

extension HomeInteractor: HomeBusinessLogic {

    func onViewDidLoad() {
        loadTools()
    }

    func reloadTools() {
        loadTools()
    }

    func handleToolSelection(at row: Int) {
        guard usefulTools.indices.contains(row) else { return }
        let selectedTool = usefulTools[row]
        guard
            let toolLink = selectedTool.link,
            let url = URL(string: toolLink)
        else { return }
        presenter.presentURL(url)
    }

    func handleRemoveToolSelection(_ toolId: UInt) {
        guard let selectedTool = usefulTools.first(where: { $0.id == toolId }) else { return }
        self.selectedTool = selectedTool
    }
}

// MARK: - DeleteToolDelegate

extension HomeInteractor: RemoveToolDelegate {

    func handleToolDeletion(toolId: UInt) {
        guard let toolIndex = usefulTools.firstIndex(where: { $0.id == toolId }) else { return }
        usefulTools.remove(at: toolIndex)
        updateUsefulTools()
    }
}
