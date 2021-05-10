//
//  AddNewToolPresenterTests.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 10/05/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import XCTest
@testable import VeryUsefulToolstoRemember

final class AddNewToolPresenterTests: XCTestCase {

    func test_presentRemoveToolResponse_whenResponseIsSuccess_shouldCallCorrectMethodInViewController() {
        // Given
        let viewControllerSpy = AddNewToolDisplayLogicSpy()
        let sut = makeSUT(viewController: viewControllerSpy)
        let expectedViewState = AddNewTool.ViewState.success

        // When
        sut.presentToolsResponse(.success)

        // Then
        XCTAssertEqual(String(describing: viewControllerSpy.displayAddToolViewStatePassedViewStates), String(describing: [expectedViewState]))
    }

    func test_presentRemoveToolResponse_whenResponseIsLoading_shouldCallCorrectMethodInViewController() {
        // Given
        let viewControllerSpy = AddNewToolDisplayLogicSpy()
        let sut = makeSUT(viewController: viewControllerSpy)
        let expectedViewState = AddNewTool.ViewState.loading

        // When
        sut.presentToolsResponse(.loading)

        // Then
        XCTAssertEqual(String(describing: viewControllerSpy.displayAddToolViewStatePassedViewStates), String(describing: [expectedViewState]))
    }

    func test_presentRemoveToolResponse_whenResponseIsError_shouldCallCorrectMethodInViewController() {
        // Given
        let viewControllerSpy = AddNewToolDisplayLogicSpy()
        let sut = makeSUT(viewController: viewControllerSpy)
        let expectedViewState = AddNewTool.ViewState.error

        // When
        sut.presentToolsResponse(.error)

        // Then
        XCTAssertEqual(String(describing: viewControllerSpy.displayAddToolViewStatePassedViewStates), String(describing: [expectedViewState]))
    }

    // MARK: - Test Helpers

    private func makeSUT(
        viewController: AddNewToolDisplayLogic = AddNewToolDisplayLogicDummy()
    ) -> AddNewToolPresenter {
        let sut = AddNewToolPresenter()
        sut.viewController = viewController
        return sut
    }

}

final class AddNewToolDisplayLogicSpy: AddNewToolDisplayLogic {

    private(set) var displayAddToolViewStatePassedViewStates = [AddNewTool.ViewState]()

    func displayAddToolViewState(_ viewState: AddNewTool.ViewState) {
        displayAddToolViewStatePassedViewStates.append(viewState)
    }
}
