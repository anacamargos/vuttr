//
//  RemoveToolInteractorTests.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 10/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import XCTest
@testable import VeryUsefulToolstoRemember

final class RemoveToolInteractorTests: XCTestCase {

    func test_onViewDidLoad_shouldCallCorrectMethodInPresenterWithCorrectParameters() {
        // Given
        let presenterSpy = RemoveToolPresenterSpy()
        let mockParameter = RemoveToolSceneParameters.mock
        let sut = makeSUT(presenter: presenterSpy, parameters: mockParameter)

        // When
        sut.onViewDidLoad()

        // Then
        XCTAssertEqual(String(describing: presenterSpy.presentToolNamePassedToolName), String(describing: [mockParameter.toolName]))
    }

    func test_handleRemoveToolAction_whenUseCaseSucceeds_shouldCallCorrectMethodInPresenterWithCorrectParameters() {
        // Given
        let presenterSpy = RemoveToolPresenterSpy()
        let useCaseStub = DeleteToolUseCaseStub()
        useCaseStub.executeResultToBeReturned = .success(.init())
        let sut = makeSUT(presenter: presenterSpy, deleteToolUseCase: useCaseStub)
        let expectedResponse = RemoveTool.Response.success

        // When
        sut.handleRemoveToolAction()

        // Then
        XCTAssertEqual(String(describing: presenterSpy.presentRemoveToolResponsePassedResponses), String(describing: [.loading, expectedResponse]))
    }

    func test_handleRemoveToolAction_whenUseCaseFails_shouldCallCorrectMethodInPresenterWithCorrectParameters() {
        // Given
        let presenterSpy = RemoveToolPresenterSpy()
        let useCaseStub = DeleteToolUseCaseStub()
        useCaseStub.executeResultToBeReturned = .failure(.genericError)
        let sut = makeSUT(presenter: presenterSpy, deleteToolUseCase: useCaseStub)
        let expectedResponse = RemoveTool.Response.error

        // When
        sut.handleRemoveToolAction()

        // Then
        XCTAssertEqual(String(describing: presenterSpy.presentRemoveToolResponsePassedResponses), String(describing: [.loading, expectedResponse]))
    }

    // MARK: - Test Helpers

    private func makeSUT(
        presenter: RemoveToolPresentationLogic = RemoveToolPresenterDummy(),
        parameters: RemoveToolSceneParameters = .mock,
        deleteToolUseCase: DeleteToolUseCaseProvider = DeleteToolUseCaseDummy(),
        file: StaticString = #file,
        line: UInt = #line
    ) -> RemoveToolInteractor {
        let sut = RemoveToolInteractor(
            presenter: presenter,
            parameters: parameters,
            deleteToolUseCase: deleteToolUseCase
        )
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}

final class DeleteToolUseCaseStub: DeleteToolUseCaseProvider {

    var executeResultToBeReturned: Result<NoEntity, DeleteToolUseCaseError> = .success(.init())

    func execute(toolId: UInt, then handle: @escaping (Result<NoEntity, DeleteToolUseCaseError>) -> Void) {
        handle(executeResultToBeReturned)
    }
}
