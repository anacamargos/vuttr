//
//  AddNewToolInteractorTests.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 11/05/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import XCTest
@testable import VeryUsefulToolstoRemember

final class AddNewToolInteractorTests: XCTestCase {

    func test_handleNewToolCreation_whenUseCaseSucceeds_shouldCallCorrectMethodInPresenterWithCorrectParameters() {
        // Given
        let delegateSpy = AddNewToolDelegateSpy()
        let presenterSpy = AddNewToolPresenterSpy()
        let useCaseStub = CreateNewToolUseCaseStub()
        useCaseStub.executeResultToBeReturned = .success(.mock)
        let sut = makeSUT(presenter: presenterSpy, createNewToolUseCase: useCaseStub, delegate: delegateSpy)
        let expectedResponse = AddNewTool.Response.success

        // When
        sut.handleNewToolCreation(.mock)

        // Then
        XCTAssertEqual(String(describing: presenterSpy.presentToolsResponsePassedResponses), String(describing: [.loading, expectedResponse]))
        XCTAssertEqual(String(describing: delegateSpy.handleToolCreationPassedTool), String(describing: [GetUsefulToolsUseCaseModels.Tool.mock]))
    }

    func test_handleNewToolCreation_whenUseCaseFails_shouldCallCorrectMethodInPresenterWithCorrectParameters() {
        // Given
        let presenterSpy = AddNewToolPresenterSpy()
        let useCaseStub = CreateNewToolUseCaseStub()
        useCaseStub.executeResultToBeReturned = .failure(.genericError)
        let sut = makeSUT(presenter: presenterSpy, createNewToolUseCase: useCaseStub)
        let expectedResponse = AddNewTool.Response.error

        // When
        sut.handleNewToolCreation(.mock)

        // Then
        XCTAssertEqual(String(describing: presenterSpy.presentToolsResponsePassedResponses), String(describing: [.loading, expectedResponse]))
    }

    // MARK: - Private Methods

    private func makeSUT(
        presenter: AddNewToolPresentationLogic = AddNewToolPresenterDummy(),
        createNewToolUseCase: CreateNewToolUseCaseProvider = CreateNewToolUseCaseDummy(),
        delegate: AddNewToolDelegate? = nil
    ) -> AddNewToolInteractor {
        .init(presenter: presenter, createNewToolUseCase: createNewToolUseCase, delegate: delegate)
    }

}

final class AddNewToolPresenterDummy: AddNewToolPresentationLogic {
    func presentToolsResponse(_ response: AddNewTool.Response) {}
}

final class AddNewToolPresenterSpy: AddNewToolPresentationLogic {

    private(set) var presentToolsResponsePassedResponses = [AddNewTool.Response]()

    func presentToolsResponse(_ response: AddNewTool.Response) {
        presentToolsResponsePassedResponses.append(response)
    }
}

final class CreateNewToolUseCaseDummy: CreateNewToolUseCaseProvider {
    func execute(request: AddNewTool.Request, then handle: @escaping (Result<GetUsefulToolsUseCaseModels.Tool, CreateNewToolUseCaseError>) -> Void) {}
}

final class CreateNewToolUseCaseStub: CreateNewToolUseCaseProvider {

    var executeResultToBeReturned: Result<GetUsefulToolsUseCaseModels.Tool, CreateNewToolUseCaseError> = .success(.mock)

    func execute(request: AddNewTool.Request, then handle: @escaping (Result<GetUsefulToolsUseCaseModels.Tool, CreateNewToolUseCaseError>) -> Void) {
        handle(executeResultToBeReturned)
    }
}

final class AddNewToolDelegateSpy: AddNewToolDelegate {

    private(set) var handleToolCreationPassedTool = [GetUsefulToolsUseCaseModels.Tool]()

    func handleToolCreation(_ tool: GetUsefulToolsUseCaseModels.Tool) {
        handleToolCreationPassedTool.append(tool)
    }
}
