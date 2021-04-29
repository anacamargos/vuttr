//
//  RemoveToolPresenterTests.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 10/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import XCTest
@testable import VeryUsefulToolstoRemember

final class RemoveToolPresenterTests: XCTestCase {

    func test_presentToolName_shouldCallCorrectMethodInViewController() {
        // Given
        let viewControllerSpy = RemoveToolDisplayLogicSpy()
        let sut = makeSUT(viewController: viewControllerSpy)
        let toolName = "Notion"

        // When
        sut.presentToolName(toolName)

        // Then
        XCTAssertEqual(String(describing: viewControllerSpy.displayToolNamePassedToolNames), String(describing: [toolName]))
    }

    func test_presentRemoveToolResponse_whenResponseIsError_shouldCallCorrectMethodInViewController() {
        // Given
        let viewControllerSpy = RemoveToolDisplayLogicSpy()
        let sut = makeSUT(viewController: viewControllerSpy)
        let expectedViewState = RemoveTool.ViewState.error

        // When
        sut.presentRemoveToolResponse(.error)

        // Then
        XCTAssertEqual(String(describing: viewControllerSpy.displayDeleteToolViewStatePassedViewStates), String(describing: [expectedViewState]))
    }

    func test_presentRemoveToolResponse_whenResponseIsLoading_shouldCallCorrectMethodInViewController() {
        // Given
        let viewControllerSpy = RemoveToolDisplayLogicSpy()
        let sut = makeSUT(viewController: viewControllerSpy)
        let expectedViewState = RemoveTool.ViewState.loading

        // When
        sut.presentRemoveToolResponse(.loading)

        // Then
        XCTAssertEqual(String(describing: viewControllerSpy.displayDeleteToolViewStatePassedViewStates), String(describing: [expectedViewState]))
    }

    func test_presentRemoveToolResponse_whenResponseIsSuccess_shouldCallCorrectMethodInViewController() {
        // Given
        let viewControllerSpy = RemoveToolDisplayLogicSpy()
        let sut = makeSUT(viewController: viewControllerSpy)
        let expectedViewState = RemoveTool.ViewState.success

        // When
        sut.presentRemoveToolResponse(.success)

        // Then
        XCTAssertEqual(String(describing: viewControllerSpy.displayDeleteToolViewStatePassedViewStates), String(describing: [expectedViewState]))
    }

    // MARK: - Test Helpers

    private func makeSUT(
        viewController: RemoveToolDisplayLogic = RemoveToolDisplayLogicDummy(),
        file: StaticString = #file,
        line: UInt = #line
    ) -> RemoveToolPresenter {
        let sut = RemoveToolPresenter()
        sut.viewController = viewController
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(viewController, file: file, line: line)
        return sut
    }

}
