//
//  CreateNewToolUseCaseDummy.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 13/05/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation
@testable import VeryUsefulToolstoRemember

final class CreateNewToolUseCaseDummy: CreateNewToolUseCaseProvider {
    func execute(request: AddNewTool.Request, then handle: @escaping (Result<GetUsefulToolsUseCaseModels.Tool, CreateNewToolUseCaseError>) -> Void) {}
}
