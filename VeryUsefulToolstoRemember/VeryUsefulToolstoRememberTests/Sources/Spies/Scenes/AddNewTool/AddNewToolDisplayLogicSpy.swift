//
//  AddNewToolDisplayLogicSpy.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 10/05/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation
@testable import VeryUsefulToolstoRemember

final class AddNewToolDisplayLogicSpy: AddNewToolDisplayLogic {

    private(set) var displayAddToolViewStatePassedViewStates = [AddNewTool.ViewState]()

    func displayAddToolViewState(_ viewState: AddNewTool.ViewState) {
        displayAddToolViewStatePassedViewStates.append(viewState)
    }
}
