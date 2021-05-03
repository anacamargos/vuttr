//
//  ToolsServicesDummy.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 26/04/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation
@testable import VeryUsefulToolstoRemember

final class ToolsServicesDummy: ToolsServicesProvider {
    func getAllTools(then handle: @escaping (Result<[ToolResponseEntity], ToolsServiceError>) -> Void) {}
    func deleteTool(id: UInt, then handle: @escaping (Result<NoEntity, ToolsServiceError>) -> Void) {}
    func createNewTool(parameters: CreateNewToolParameters, then handle: @escaping (Result<ToolResponseEntity, ToolsServiceError>) -> Void) {}
}
