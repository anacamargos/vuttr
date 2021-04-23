//
//  GetUsefulToolsUseCaseTests.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 23/04/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import XCTest
@testable import VeryUsefulToolstoRemember

final class GetUsefulToolsUseCaseTests {

    // MARK: - Test Helpers

    private func makeSUT(
        service: ToolsServicesProvider = ToolsServicesDummy()
    ) -> GetUsefulToolsUseCase {
        let sut = GetUsefulToolsUseCase(service: service)
        return sut
    }
}

final class ToolsServicesDummy: ToolsServicesProvider {
    func getAllTools(then handle: @escaping (Result<[ToolResponseEntity], ToolsServiceError>) -> Void) {}
    func deleteTool(id: UInt, then handle: @escaping (Result<NoEntity, ToolsServiceError>) -> Void) {}
}

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
