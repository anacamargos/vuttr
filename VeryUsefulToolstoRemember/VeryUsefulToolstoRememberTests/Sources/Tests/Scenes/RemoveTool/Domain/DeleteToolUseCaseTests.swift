//
//  DeleteToolUseCaseTests.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 27/04/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import XCTest
@testable import VeryUsefulToolstoRemember

final class DeleteToolUseCaseTests: XCTestCase {

    func test_execute_whenServiceFails_shouldReturnCorrectError() {
        let serviceStub = ToolsServicesStub()
        serviceStub.deleteToolResultToBeReturned = .failure(.genericError)
        let sut = makeSUT(service: serviceStub)
        expect(sut, toCompleteWith: .failure(.genericError))
    }

    func test_execute_whenServiceSucceeds_shouldReturnCorrectModel() {
        let serviceStub = ToolsServicesStub()
        serviceStub.deleteToolResultToBeReturned = .success(.init())
        let sut = makeSUT(service: serviceStub)
        expect(sut, toCompleteWith: .success(.init()))
    }

    // MARK: - Test Helpers

    func expect(
        _ sut: DeleteToolUseCase,
        toCompleteWith expectedResult: Result<NoEntity, DeleteToolUseCaseError>,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        let exp = expectation(description: "Wait for completion")
        sut.execute(toolId: .zero) { receivedResult in
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
    ) -> DeleteToolUseCase {
        let sut = DeleteToolUseCase(service: service)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}
