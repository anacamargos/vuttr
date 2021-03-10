//
//  RemoveToolPresenter.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 09/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation

protocol RemoveToolPresentationLogic {
    func presentToolName(_ toolName: String)
}

final class RemoveToolPresenter {
    
    // MARK: - Dependencies
    
    weak var viewController: RemoveToolDisplayLogic?
}

// MARK: - RemoveToolPresentationLogic

extension RemoveToolPresenter: RemoveToolPresentationLogic {
    
    func presentToolName(_ toolName: String) {
        viewController?.displayToolName(toolName)
    }
}
