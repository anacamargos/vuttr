//
//  RemoveToolViewController.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 08/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import UIKit

protocol RemoveToolDisplayLogic: AnyObject {
    func displayToolName(_ toolName: String)
    func displayDeleteToolViewState(_ viewState: RemoveTool.ViewState)
}

final class RemoveToolViewController: UIViewController {

    // MARK: - Dependencies

    private let interactor: RemoveToolBusinessLogic
    private let router: RemoveToolRoutingLogic

    // MARK: - View Components

    weak var contentView: RemoveToolContentViewProtocol?

    // MARK: - Initializers

    init(
        interactor: RemoveToolBusinessLogic,
        router: RemoveToolRoutingLogic
    ) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.onViewDidLoad()
    }

    override func loadView() {
        view = RemoveToolContentView(
            onTappedCloseButtonClosure: { [weak self] in self?.onTappedCloseButtonAction() },
            onTappedRemoveToolButtonClosure: { [weak self] in self?.onTappedRemoveToolButtonAction() }
        )
        contentView = view as? RemoveToolContentViewProtocol
    }

    // MARK: - Private Methods

    private func onTappedCloseButtonAction() {
        router.routeToPreviousScene()
    }

    private func onTappedRemoveToolButtonAction() {
        interactor.handleRemoveToolAction()
    }

}

// MARK: - RemoveToolDisplayLogic

extension RemoveToolViewController: RemoveToolDisplayLogic {

    func displayToolName(_ toolName: String) {
        contentView?.setupViewData(toolName)
    }

    func displayDeleteToolViewState(_ viewState: RemoveTool.ViewState) {
        switch viewState {
        case .loading:
            contentView?.setupLoadingState(true)
        case .success:
            contentView?.setupLoadingState(false)
        case .error:
            contentView?.setupLoadingState(false)
        }
    }
}
