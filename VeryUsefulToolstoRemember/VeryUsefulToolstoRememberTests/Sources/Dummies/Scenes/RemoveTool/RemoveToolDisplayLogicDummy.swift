//
//  RemoveToolDisplayLogicDummy.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 10/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation
@testable import VeryUsefulToolstoRemember

final class RemoveToolDisplayLogicDummy: RemoveToolDisplayLogic {
    func displayToolName(_ toolName: String) {}
    func displayDeleteToolViewState(_ viewState: RemoveTool.ViewState) {}
}
