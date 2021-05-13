//
//  CreateNewToolUseCaseTests.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 05/05/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import XCTest
@testable import VeryUsefulToolstoRemember

final class CreateNewToolUseCaseTests: XCTestCase {

    func test_execute_whenServiceFails_shouldReturnCorrectError() {
        let serviceStub = ToolsServicesStub()
        serviceStub.createNewToolResultToBeReturned = .failure(.genericError)
        let sut = makeSUT(service: serviceStub)
        expect(sut, toCompleteWith: .failure(.genericError))
    }

    func test_execute_whenServiceSucceeds_shouldReturnCorrectModel() {
        let serviceStub = ToolsServicesStub()
        serviceStub.createNewToolResultToBeReturned = .success(.mock)
        let sut = makeSUT(service: serviceStub)
        expect(sut, toCompleteWith: .success(.mock))
    }

    // MARK: - Test Helpers

    func expect(
        _ sut: CreateNewToolUseCase,
        toCompleteWith expectedResult: Result<GetUsefulToolsUseCaseModels.Tool, CreateNewToolUseCaseError>,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        let exp = expectation(description: "Wait for completion")
        sut.execute(request: .mock) { receivedResult in
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
        service: ToolsServicesProvider = ToolsServicesDummy(),
        file: StaticString = #file,
        line: UInt = #line
    ) -> CreateNewToolUseCase {
        let sut = CreateNewToolUseCase(service: service)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }

}
