//
//  DeleteToolUseCaseDummy.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 28/04/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation
@testable import VeryUsefulToolstoRemember

final class DeleteToolUseCaseDummy: DeleteToolUseCaseProvider {
    func execute(toolId: UInt, then handle: @escaping (Result<NoEntity, DeleteToolUseCaseError>) -> Void) {}
}
