//
//  AddNewToolPresenter.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 05/05/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation

protocol AddNewToolPresentationLogic {
    func presentToolsResponse(_ response: AddNewTool.Response)
}

final class AddNewToolPresenter {

    // MARK: - Dependencies

    weak var viewController: AddNewToolDisplayLogic?
}

// MARK: - AddNewToolPresentationLogic

extension AddNewToolPresenter: AddNewToolPresentationLogic {

    func presentToolsResponse(_ response: AddNewTool.Response) {
        let viewState: AddNewTool.ViewState
        switch response {
        case .success:
            viewState = .success
        case .loading:
            viewState = .loading
        case .error:
            viewState = .error
        }
        viewController?.displayAddToolViewState(viewState)
    }
}
