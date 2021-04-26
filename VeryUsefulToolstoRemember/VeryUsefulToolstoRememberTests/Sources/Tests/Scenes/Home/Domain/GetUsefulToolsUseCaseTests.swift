//
//  GetUsefulToolsUseCaseTests.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 23/04/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import XCTest
@testable import VeryUsefulToolstoRemember

final class GetUsefulToolsUseCaseTests: XCTestCase {

    func test_execute_whenServiceFails_shouldReturnCorrectError() {
        let serviceStub = ToolsServicesStub()
        serviceStub.getAllToolsResultToBeReturned = .failure(.genericError)
        let sut = makeSUT(service: serviceStub)
        expect(sut, toCompleteWith: .failure(.genericError))
    }

    func test_execute_whenServiceSucceeds_shouldReturnCorrectModel() {
        let serviceStub = ToolsServicesStub()
        serviceStub.getAllToolsResultToBeReturned = .success([.mock])
        let sut = makeSUT(service: serviceStub)
        expect(sut, toCompleteWith: .success([.mock]))
    }

    // MARK: - Test Helpers

    func expect(
        _ sut: GetUsefulToolsUseCase,
        toCompleteWith expectedResult: Result<[GetUsefulToolsUseCaseModels.Tool], GetUsefulToolsUseCaseError>,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        let exp = expectation(description: "Wait for completion")
        sut.execute { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedResponse), .success(expectedResponse)):
                XCTAssertEqual(String(describing: receivedResponse), String(describing: expectedResponse), file: file, line: line)
            case let (.failure(receivedError), .failure(expectedError)):
                XCTAssertEqual(receivedError, expectedError, file: file, line: line)
            default:
                XCTFail("Expected result \(expectedResult), got \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }

    private func makeSUT(
        service: ToolsServicesProvider = ToolsServicesDummy()
    ) -> GetUsefulToolsUseCase {
        let sut = GetUsefulToolsUseCase(service: service)
        return sut
    }
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
