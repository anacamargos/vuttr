//
//  HomeContentViewSpy.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 17/02/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation
@testable import VeryUsefulToolstoRemember

final class HomeContentViewSpy: HomeContentViewProtocol {

    private(set) var setupUsefulToolsStatePassedViewStates = [Home.UsefulTools.ViewState]()

    func setupUsefulToolsState(_ viewState: Home.UsefulTools.ViewState) {
        setupUsefulToolsStatePassedViewStates.append(viewState)
    }
}
