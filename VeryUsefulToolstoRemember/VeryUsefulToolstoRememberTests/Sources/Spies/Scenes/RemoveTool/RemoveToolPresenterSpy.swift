//
//  RemoveToolPresenterSpy.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 10/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation
@testable import VeryUsefulToolstoRemember

final class RemoveToolPresenterSpy: RemoveToolPresentationLogic {

    private(set) var presentToolNamePassedToolName = [String]()

    func presentToolName(_ toolName: String) {
        presentToolNamePassedToolName.append(toolName)
    }

    private(set) var presentRemoveToolResponsePassedResponses = [RemoveTool.Response]()

    func presentRemoveToolResponse(_ response: RemoveTool.Response) {
        presentRemoveToolResponsePassedResponses.append(response)
    }
}
