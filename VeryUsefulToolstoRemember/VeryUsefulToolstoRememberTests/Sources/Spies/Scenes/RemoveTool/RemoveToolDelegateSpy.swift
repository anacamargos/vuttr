//
//  RemoveToolDelegateSpy.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 14/05/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation
@testable import VeryUsefulToolstoRemember

final class RemoveToolDelegateSpy: RemoveToolDelegate {

    private(set) var handleToolDeletionPassedIds = [UInt]()

    func handleToolDeletion(toolId: UInt) {
        handleToolDeletionPassedIds.append(toolId)
    }
}
