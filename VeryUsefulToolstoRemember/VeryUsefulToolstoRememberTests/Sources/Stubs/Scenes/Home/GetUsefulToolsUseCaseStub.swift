//
//  GetUsefulToolsUseCaseStub.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 02/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation
@testable import VeryUsefulToolstoRemember

final class GetUsefulToolsUseCaseStub: GetUsefulToolsUseCaseProvider {

    var executeResultToBeReturned: Result<[GetUsefulToolsUseCaseModels.Tool], GetUsefulToolsUseCaseError> = .success([.mock])

    func execute(then handle: @escaping (Result<[GetUsefulToolsUseCaseModels.Tool], GetUsefulToolsUseCaseError>) -> Void) {
        handle(executeResultToBeReturned)
    }
}
