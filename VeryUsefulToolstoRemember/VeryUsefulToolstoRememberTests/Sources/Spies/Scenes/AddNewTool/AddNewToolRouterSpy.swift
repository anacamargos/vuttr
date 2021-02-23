//
//  AddNewToolRouterSpy.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 23/02/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation
@testable import VeryUsefulToolstoRemember

final class AddNewToolRouterSpy: AddNewToolRoutingLogic {
    
    private(set) var routeToPreviousSceneCalled = false
    
    func routeToPreviousScene() {
        routeToPreviousSceneCalled = true
    }
}
