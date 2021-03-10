//
//  RemoveToolDisplayLogicSpy.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 10/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation
@testable import VeryUsefulToolstoRemember

final class RemoveToolDisplayLogicSpy: RemoveToolDisplayLogic {
    
    private(set) var displayToolNamePassedToolNames = [String]()
    
    func displayToolName(_ toolName: String) {
        displayToolNamePassedToolNames.append(toolName)
    }
}
