//
//  RemoveToolContentViewSpy.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 28/04/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation
@testable import VeryUsefulToolstoRemember

final class RemoveToolContentViewSpy: RemoveToolContentViewProtocol {

    private(set) var setupViewDataPassedToolNames = [String]()

    func setupViewData(_ toolName: String) {
        setupViewDataPassedToolNames.append(toolName)
    }

    private(set) var setupLoadingStatePassedBooleans = [Bool]()

    func setupLoadingState(_ isLoading: Bool) {
        setupLoadingStatePassedBooleans.append(isLoading)
    }
}
