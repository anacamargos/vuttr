//
//  RemoveToolInteractorSpy.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 28/04/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation
@testable import VeryUsefulToolstoRemember

final class RemoveToolInteractorSpy: RemoveToolBusinessLogic {

    private(set) var onViewDidLoadCalled = false

    func onViewDidLoad() {
        onViewDidLoadCalled = true
    }

    private(set) var handleRemoveToolActionCalled = false

    func handleRemoveToolAction() {
        handleRemoveToolActionCalled = true
    }
}
