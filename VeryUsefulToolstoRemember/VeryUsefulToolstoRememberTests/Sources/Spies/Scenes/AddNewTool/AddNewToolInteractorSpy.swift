//
//  AddNewToolInteractorSpy.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 11/05/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation
@testable import VeryUsefulToolstoRemember

final class AddNewToolInteractorSpy: AddNewToolBusinessLogic {

    private(set) var handleNewToolCreationPassedRequests = [AddNewTool.Request]()

    func handleNewToolCreation(_ request: AddNewTool.Request) {
        handleNewToolCreationPassedRequests.append(request)
    }
}
