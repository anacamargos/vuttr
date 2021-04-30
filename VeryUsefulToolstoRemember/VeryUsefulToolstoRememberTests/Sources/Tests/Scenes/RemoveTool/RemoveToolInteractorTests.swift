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
        let delegateSpy = RemoveToolDelegateSpy()
        useCaseStub.executeResultToBeReturned = .success(.init())
        let sut = makeSUT(presenter: presenterSpy, deleteToolUseCase: useCaseStub, delegate: delegateSpy)
        let expectedResponse = RemoveTool.Response.success

        // When
        sut.handleRemoveToolAction()

        // Then
        XCTAssertEqual(String(describing: presenterSpy.presentRemoveToolResponsePassedResponses), String(describing: [.loading, expectedResponse]))
        XCTAssertEqual(String(describing: delegateSpy.handleToolDeletionPassedIds), String(describing: [UInt.zero]))
    }

    func test_handleRemoveToolAction_whenUseCaseFails_shouldCallCorrectMethodInPresenterWithCorrectParameters() {
        // Given
        let presenterSpy = RemoveToolPresenterSpy()
        let useCaseStub = DeleteToolUseCaseStub()
        let delegateSpy = RemoveToolDelegateSpy()
        useCaseStub.executeResultToBeReturned = .failure(.genericError)
        let sut = makeSUT(presenter: presenterSpy, deleteToolUseCase: useCaseStub, delegate: delegateSpy)
        let expectedResponse = RemoveTool.Response.error

        // When
        sut.handleRemoveToolAction()

        // Then
        XCTAssertEqual(String(describing: presenterSpy.presentRemoveToolResponsePassedResponses), String(describing: [.loading, expectedResponse]))
        XCTAssertEqual(String(describing: delegateSpy.handleToolDeletionPassedIds), String(describing: []))
    }

    // MARK: - Test Helpers

    private func makeSUT(
        presenter: RemoveToolPresentationLogic = RemoveToolPresenterDummy(),
        parameters: RemoveToolSceneParameters = .mock,
        deleteToolUseCase: DeleteToolUseCaseProvider = DeleteToolUseCaseDummy(),
        delegate: RemoveToolDelegate? = nil,
        file: StaticString = #file,
        line: UInt = #line
    ) -> RemoveToolInteractor {
        let sut = RemoveToolInteractor(
            presenter: presenter,
            parameters: parameters,
            deleteToolUseCase: deleteToolUseCase,
            delegate: delegate
        )
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}

final class RemoveToolDelegateSpy: RemoveToolDelegate {

    private(set) var handleToolDeletionPassedIds = [UInt]()

    func handleToolDeletion(toolId: UInt) {
        handleToolDeletionPassedIds.append(toolId)
    }
}
