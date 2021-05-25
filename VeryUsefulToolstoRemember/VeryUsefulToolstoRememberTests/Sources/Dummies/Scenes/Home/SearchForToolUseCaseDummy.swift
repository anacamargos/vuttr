//
//  SearchForToolUseCaseDummy.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 25/05/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

@testable import VeryUsefulToolstoRemember

final class SearchForToolUseCaseDummy: SearchForToolUseCaseProvider {
    func execute(request: SearchForToolUseCaseModels.Request, then handle: @escaping (Result<[GetUsefulToolsUseCaseModels.Tool], SearchForToolUseCaseError>) -> Void) {}
}
