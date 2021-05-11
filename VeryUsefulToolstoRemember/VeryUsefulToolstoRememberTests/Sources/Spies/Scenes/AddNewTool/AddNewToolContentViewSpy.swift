//
//  AddNewToolContentViewSpy.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 11/05/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation
@testable import VeryUsefulToolstoRemember

final class AddNewToolContentViewSpy: AddNewToolContentViewProtocol {

    private(set) var setupLoadingStatePassedBooleans = [Bool]()

    func setupLoadingState(_ isLoading: Bool) {
        setupLoadingStatePassedBooleans.append(isLoading)
    }
}
