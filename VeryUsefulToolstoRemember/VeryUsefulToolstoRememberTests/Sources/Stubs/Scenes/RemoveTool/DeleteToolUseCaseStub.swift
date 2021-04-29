//
//  DeleteToolUseCaseStub.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 29/04/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation
@testable import VeryUsefulToolstoRemember

final class DeleteToolUseCaseStub: DeleteToolUseCaseProvider {

    var executeResultToBeReturned: Result<NoEntity, DeleteToolUseCaseError> = .success(.init())

    func execute(toolId: UInt, then handle: @escaping (Result<NoEntity, DeleteToolUseCaseError>) -> Void) {
        handle(executeResultToBeReturned)
    }
}
