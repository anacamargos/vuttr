//
//  AddNewToolViewController.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 18/02/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import UIKit

final class AddNewToolViewController: UIViewController {

    // MARK: - Dependencies

    private let router: AddNewToolRoutingLogic

    // MARK: - View Components

    weak var contentView: AddNewToolContentViewProtocol?

    // MARK: - Initializers

    init(
        router: AddNewToolRoutingLogic
    ) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Controller Lifecycle

    override func loadView() {
        view = AddNewToolContentView(
            onTappedCloseButtonClosure: { [weak self] in self?.onTappedCloseButtonAction() },
            onTappedAddToolButtonClosure: { [weak self] tool in self?.onTappedAddToolButtonAction(tool) }
        )
        contentView = view as? AddNewToolContentViewProtocol
    }

    // MARK: - Private Methods

    private func onTappedCloseButtonAction() {
        router.routeToPreviousScene()
    }

    private func onTappedAddToolButtonAction(_ newTool: AddNewTool.Request) {

    }
}
