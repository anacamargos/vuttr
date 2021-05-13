//
//  AddNewToolDelegateSpy.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 13/05/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation
@testable import VeryUsefulToolstoRemember

final class AddNewToolDelegateSpy: AddNewToolDelegate {

    private(set) var handleToolCreationPassedTool = [GetUsefulToolsUseCaseModels.Tool]()

    func handleToolCreation(_ tool: GetUsefulToolsUseCaseModels.Tool) {
        handleToolCreationPassedTool.append(tool)
    }
}
