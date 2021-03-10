//
//  RemoveToolPresenterSpy.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 10/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation
@testable import VeryUsefulToolstoRemember

final class RemoveToolPresenterSpy: RemoveToolPresentationLogic {
    
    private(set) var presentToolNamePassedToolName = [String]()
    
    func presentToolName(_ toolName: String) {
        presentToolNamePassedToolName.append(toolName)
    }
}
