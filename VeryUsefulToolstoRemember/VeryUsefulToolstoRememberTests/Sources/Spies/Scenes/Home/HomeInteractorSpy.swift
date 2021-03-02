//
//  HomeInteractorSpy.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 02/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation
@testable import VeryUsefulToolstoRemember

final class HomeInteractorSpy: HomeBusinessLogic {
    
    private(set) var onViewDidLoadCalled = false
    
    func onViewDidLoad() {
        onViewDidLoadCalled = true
    }
    
    private(set) var handleToolSelectionCalled = false
    
    func handleToolSelection(at row: Int) {
        handleToolSelectionCalled = true
    }
}
