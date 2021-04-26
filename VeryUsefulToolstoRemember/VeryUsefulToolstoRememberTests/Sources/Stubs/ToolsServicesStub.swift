//
//  ToolsServicesStub.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 26/04/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation
@testable import VeryUsefulToolstoRemember

final class ToolsServicesStub: ToolsServicesProvider {

    var getAllToolsResultToBeReturned: Result<[ToolResponseEntity], ToolsServiceError> = .success([.mock])

    func getAllTools(then handle: @escaping (Result<[ToolResponseEntity], ToolsServiceError>) -> Void) {
        handle(getAllToolsResultToBeReturned)
    }

    var deleteToolResultToBeReturned: Result<NoEntity, ToolsServiceError> = .success(.init())

    func deleteTool(id: UInt, then handle: @escaping (Result<NoEntity, ToolsServiceError>) -> Void) {
        handle(deleteToolResultToBeReturned)
    }
}
