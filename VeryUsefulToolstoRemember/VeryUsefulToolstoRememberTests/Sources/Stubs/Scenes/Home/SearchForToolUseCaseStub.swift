//
//  SearchForToolUseCaseStub.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 28/06/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation
@testable import VeryUsefulToolstoRemember

final class SearchForToolUseCaseStub: SearchForToolUseCaseProvider {

    var executeResultToBeReturned: Result<[GetUsefulToolsUseCaseModels.Tool], SearchForToolUseCaseError> = .success([.mock])

    func execute(request: SearchForToolUseCaseModels.Request, then handle: @escaping (Result<[GetUsefulToolsUseCaseModels.Tool], SearchForToolUseCaseError>) -> Void) {
        handle(executeResultToBeReturned)
    }
}
