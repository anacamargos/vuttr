//
//  HomeInteractorTests.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 01/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import XCTest
@testable import VeryUsefulToolstoRemember

final class HomeInteractorTests: XCTestCase {

    func test_onViewDidLoad_whenUseCaseSucceeds_shouldCallCorrectMethodInPresenterWithCorrectParameters() {
        // Given
        let useCaseStub = GetUsefulToolsUseCaseStub()
        useCaseStub.executeResultToBeReturned = .success([.mock])
        let presenterSpy = HomePresenterSpy()
        let sut = makeSUT(presenter: presenterSpy, getToolsUseCase: useCaseStub)
        let expectedResponse = Home.UsefulTools.Response.content([.mock])

        // When
        sut.onViewDidLoad()

        // Then
        XCTAssertEqual(String(describing: presenterSpy.presentToolsResponsePassedResponses), String(describing: [.loading, expectedResponse]))
    }

    func test_onViewDidLoad_whenUseCaseSucceedsWithNoTools_shouldCallCorrectMethodInPresenterWithCorrectParameters() {
        // Given
        let useCaseStub = GetUsefulToolsUseCaseStub()
        useCaseStub.executeResultToBeReturned = .success([])
        let presenterSpy = HomePresenterSpy()
        let sut = makeSUT(presenter: presenterSpy, getToolsUseCase: useCaseStub)
        let expectedResponse = Home.UsefulTools.Response.empty

        // When
        sut.onViewDidLoad()

        // Then
        XCTAssertEqual(String(describing: presenterSpy.presentToolsResponsePassedResponses), String(describing: [.loading, expectedResponse]))
    }

    func test_onViewDidLoad_whenUseCaseFails_shouldCallCorrectMethodInPresenterWithCorrectParameters() {
        // Given
        let useCaseStub = GetUsefulToolsUseCaseStub()
        useCaseStub.executeResultToBeReturned = .failure(.genericError)
        let presenterSpy = HomePresenterSpy()
        let sut = makeSUT(presenter: presenterSpy, getToolsUseCase: useCaseStub)
        let expectedResponse = Home.UsefulTools.Response.error

        // When
        sut.onViewDidLoad()

        // Then
        XCTAssertEqual(String(describing: presenterSpy.presentToolsResponsePassedResponses), String(describing: [.loading, expectedResponse]))
    }

    func test_handleToolSelection_whenSelectedToolIsValid_shouldCallCorrectMethodInPresenterWithCorrectParameters() {
        // Given
        let useCaseStub = GetUsefulToolsUseCaseStub()
        useCaseStub.executeResultToBeReturned = .success([.mock])
        let presenterSpy = HomePresenterSpy()
        let sut = makeSUT(presenter: presenterSpy, getToolsUseCase: useCaseStub)
        // swiftlint:disable:next force_unwrapping
        let expectedURL = URL(string: "https://notion.so")!

        // When
        sut.onViewDidLoad()
        sut.handleToolSelection(at: .zero)

        // Then
        XCTAssertEqual(presenterSpy.presentURLPassedURLs, [expectedURL])
    }

    func test_handleToolSelection_whenSelectedToolIsNotValid_shouldCallNotCallMethodInPresenter() {
        // Given
        let presenterSpy = HomePresenterSpy()
        let sut = makeSUT(presenter: presenterSpy)

        // When
        sut.handleToolSelection(at: .zero)

        // Then
        XCTAssertEqual(presenterSpy.presentURLPassedURLs, [])
    }

    func test_handleToolSelection_whenSelectedToolIsValidButURLIsNotValid_shouldCallNotCallMethodInPresenter() {
        // Given
        let useCaseStub = GetUsefulToolsUseCaseStub()
        useCaseStub.executeResultToBeReturned = .success([.mockWithInvalidLink])
        let presenterSpy = HomePresenterSpy()
        let sut = makeSUT(presenter: presenterSpy, getToolsUseCase: useCaseStub)

        // When
        sut.onViewDidLoad()
        sut.handleToolSelection(at: .zero)

        // Then
        XCTAssertEqual(presenterSpy.presentURLPassedURLs, [])
    }

    func test_handleRemoveToolSelection_shouldSelectCorrectTool() {
        // Given
        let useCaseStub = GetUsefulToolsUseCaseStub()
        useCaseStub.executeResultToBeReturned = .success([.mock])
        let sut = makeSUT(getToolsUseCase: useCaseStub)
        let expectedSelectedTool = GetUsefulToolsUseCaseModels.Tool.mock

        // When
        sut.onViewDidLoad()
        sut.handleRemoveToolSelection(.zero)

        // Then
        guard let selectedTool = sut.selectedTool else {
            XCTFail("Could not find selectedTool")
            return
        }
        XCTAssertEqual(String(describing: selectedTool), String(describing: expectedSelectedTool))
    }

    func test_handleRemoveToolSelection_whenSelectedToolIsNotFound_selectedToolShouldBeNil() {
        // Given
        let useCaseStub = GetUsefulToolsUseCaseStub()
        useCaseStub.executeResultToBeReturned = .success([.mock])
        let sut = makeSUT(getToolsUseCase: useCaseStub)

        // When
        sut.onViewDidLoad()
        sut.handleRemoveToolSelection(1)

        // Then
        XCTAssertNil(sut.selectedTool)
    }

    func test_reloadTools_whenUseCaseSucceeds_shouldCallCorrectMethodInPresenterWithCorrectParameters() {
        // Given
        let useCaseStub = GetUsefulToolsUseCaseStub()
        useCaseStub.executeResultToBeReturned = .success([.mock])
        let presenterSpy = HomePresenterSpy()
        let sut = makeSUT(presenter: presenterSpy, getToolsUseCase: useCaseStub)
        let expectedResponse = Home.UsefulTools.Response.content([.mock])

        // When
        sut.reloadTools()

        // Then
        XCTAssertEqual(String(describing: presenterSpy.presentToolsResponsePassedResponses), String(describing: [.loading, expectedResponse]))
    }

    func test_handleToolDeletion_shouldCallCorrectMethodInPresenterWithCorrectParameters() {
        // Given
        let useCaseStub = GetUsefulToolsUseCaseStub()
        useCaseStub.executeResultToBeReturned = .success([.mock, .otherMock])
        let presenterSpy = HomePresenterSpy()
        let sut = makeSUT(presenter: presenterSpy, getToolsUseCase: useCaseStub)
        let expectedResponse = Home.UsefulTools.Response.content([.otherMock])

        // When
        sut.onViewDidLoad()
        sut.handleToolDeletion(toolId: .zero)

        // Then
        XCTAssertEqual(String(describing: presenterSpy.presentToolsResponsePassedResponses), String(describing: [.loading, .content([.mock, .otherMock]), expectedResponse]))
        XCTAssertTrue(presenterSpy.presentRemoveToolSuccessMessageCalled)
    }

    func test_handleToolDeletion_whenAllToolsAreRemoved_shouldCallCorrectMethodInPresenterWithCorrectParameters() {
        // Given
        let useCaseStub = GetUsefulToolsUseCaseStub()
        useCaseStub.executeResultToBeReturned = .success([.mock])
        let presenterSpy = HomePresenterSpy()
        let sut = makeSUT(presenter: presenterSpy, getToolsUseCase: useCaseStub)
        let expectedResponse = Home.UsefulTools.Response.empty

        // When
        sut.onViewDidLoad()
        sut.handleToolDeletion(toolId: .zero)

        // Then
        XCTAssertEqual(String(describing: presenterSpy.presentToolsResponsePassedResponses), String(describing: [.loading, .content([.mock]), expectedResponse]))
        XCTAssertTrue(presenterSpy.presentRemoveToolSuccessMessageCalled)
    }

    func test_handleToolDeletion_whenIdPassedIsInvalid_shouldCallCorrectMethodInPresenterWithCorrectParameters() {
        // Given
        let useCaseStub = GetUsefulToolsUseCaseStub()
        useCaseStub.executeResultToBeReturned = .success([.mock])
        let presenterSpy = HomePresenterSpy()
        let sut = makeSUT(presenter: presenterSpy, getToolsUseCase: useCaseStub)
        let expectedResponse = Home.UsefulTools.Response.content([.mock])

        // When
        sut.onViewDidLoad()
        sut.handleToolDeletion(toolId: 1)

        // Then
        XCTAssertEqual(String(describing: presenterSpy.presentToolsResponsePassedResponses), String(describing: [.loading, expectedResponse]))
        XCTAssertFalse(presenterSpy.presentRemoveToolSuccessMessageCalled)
    }

    func test_handleToolCreation_shouldCallCorrectMethodInPresenterWithCorrectParameters() {
        // Given
        let presenterSpy = HomePresenterSpy()
        let sut = makeSUT(presenter: presenterSpy)
        let expectedResponse = Home.UsefulTools.Response.content([.mock])

        // When
        sut.handleToolCreation(.mock)

        // Then
        XCTAssertEqual(String(describing: presenterSpy.presentToolsResponsePassedResponses), String(describing: [expectedResponse]))
        XCTAssertTrue(presenterSpy.presentAddNewToolSuccessMessageCalled)
    }

    func test_searchForTool_whenUseCaseFails_shouldCallCorrectMethodInPresenterWithCorrectParameters() {
        // Given
        let useCaseStub = SearchForToolUseCaseStub()
        useCaseStub.executeResultToBeReturned = .failure(.genericError)
        let presenterSpy = HomePresenterSpy()
        let sut = makeSUT(presenter: presenterSpy, searchForToolUseCase: useCaseStub)
        let expectedResponse = Home.UsefulTools.Response.error

        // When
        sut.searchForTool(with: "")

        // Then
        XCTAssertEqual(String(describing: presenterSpy.presentToolsResponsePassedResponses), String(describing: [.loading, expectedResponse]))
    }

    func test_searchForTool_whenUseCaseSucceeds_shouldCallCorrectMethodInPresenterWithCorrectParameters() {
        // Given
        let useCaseStub = SearchForToolUseCaseStub()
        useCaseStub.executeResultToBeReturned = .success([.mock])
        let presenterSpy = HomePresenterSpy()
        let sut = makeSUT(presenter: presenterSpy, searchForToolUseCase: useCaseStub)
        let expectedResponse = Home.UsefulTools.Response.content([.mock])

        // When
        sut.searchForTool(with: "")

        // Then
        XCTAssertEqual(String(describing: presenterSpy.presentToolsResponsePassedResponses), String(describing: [.loading, expectedResponse]))
    }

    // MARK: - Test Helpers

    private func makeSUT(
        presenter: HomePresentationLogic = HomePresenterDummy(),
        getToolsUseCase: GetUsefulToolsUseCaseProvider = GetUsefulToolsUseCaseDummy(),
        searchForToolUseCase: SearchForToolUseCaseProvider = SearchForToolUseCaseDummy(),
        file: StaticString = #file,
        line: UInt = #line
    ) -> HomeInteractor {
        let sut = HomeInteractor(
            presenter: presenter,
            getToolsUseCase: getToolsUseCase,
            searchForToolUseCase: searchForToolUseCase
        )
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }

}
