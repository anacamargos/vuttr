//
//  HomeDisplayLogicSpy.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 01/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation
@testable import VeryUsefulToolstoRemember

final class HomeDisplayLogicSpy: HomeDisplayLogic {

    private(set) var displayUsefulToolsViewStatePassedViewStates = [Home.UsefulTools.ViewState]()

    func displayUsefulToolsViewState(_ viewState: Home.UsefulTools.ViewState) {
        displayUsefulToolsViewStatePassedViewStates.append(viewState)
    }

    private(set) var displayURLPassedURLs = [URL]()

    func displayURL(_ url: URL) {
        displayURLPassedURLs.append(url)
    }
}
