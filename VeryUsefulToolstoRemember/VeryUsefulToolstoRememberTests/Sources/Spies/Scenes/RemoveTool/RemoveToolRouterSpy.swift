//
//  RemoveToolRouterSpy.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 28/04/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation
@testable import VeryUsefulToolstoRemember

final class RemoveToolRouterSpy: RemoveToolRoutingLogic {

    private(set) var routeToPreviousSceneCalled = false

    func routeToPreviousScene() {
        routeToPreviousSceneCalled = true
    }
}
