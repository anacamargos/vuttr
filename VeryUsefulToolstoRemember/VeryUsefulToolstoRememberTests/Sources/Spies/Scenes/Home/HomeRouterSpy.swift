//
//  HomeRouterSpy.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 18/02/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation
@testable import VeryUsefulToolstoRemember

final class HomeRouterSpy: HomeRoutingLogic {

    private(set) var routeToAddNewToolSceneCalled = false

    func routeToAddNewToolScene() {
        routeToAddNewToolSceneCalled = true
    }

    private(set) var routeToURLPassedURLs = [URL]()

    func routeToURL(_ url: URL) {
        routeToURLPassedURLs.append(url)
    }

    private(set) var routeToRemoveToolSceneCalled = false

    func routeToRemoveToolScene() {
        routeToRemoveToolSceneCalled = true
    }
}
