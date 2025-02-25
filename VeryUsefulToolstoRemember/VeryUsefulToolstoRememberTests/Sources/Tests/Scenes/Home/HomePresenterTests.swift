//
//  HomePresenterTests.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 01/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import XCTest
@testable import VeryUsefulToolstoRemember

final class HomePresenterTests: XCTestCase {

    func test_presentToolsResponse_whenResponseIsLoading_shouldCallCorrectMethodInViewController() {
        // Given
        let viewControllerSpy = HomeDisplayLogicSpy()
        let sut = makeSUT(viewController: viewControllerSpy)
        let expectedViewState = Home.UsefulTools.ViewState.loading

        // When
        sut.presentToolsResponse(.loading)

        // Then
        XCTAssertEqual(String(describing: viewControllerSpy.displayUsefulToolsViewStatePassedViewStates), String(describing: [expectedViewState]))
    }

    func test_presentToolsResponse_whenResponseIsContent_shouldCallCorrectMethodInViewController() {
        // Given
        let viewControllerSpy = HomeDisplayLogicSpy()
        let sut = makeSUT(viewController: viewControllerSpy)
        let expectedViewState = Home.UsefulTools.ViewState.content(.init(tools: [.mock, .mock]))

        // When
        sut.presentToolsResponse(.content([.mock, .mock]))

        // Then
        XCTAssertEqual(String(describing: viewControllerSpy.displayUsefulToolsViewStatePassedViewStates), String(describing: [expectedViewState]))
    }

    func test_presentToolsResponse_whenResponseIsError_shouldCallCorrectMethodInViewController() {
        // Given
        let viewControllerSpy = HomeDisplayLogicSpy()
        let sut = makeSUT(viewController: viewControllerSpy)
        let expectedViewState = Home.UsefulTools.ViewState.error

        // When
        sut.presentToolsResponse(.error)

        // Then
        XCTAssertEqual(String(describing: viewControllerSpy.displayUsefulToolsViewStatePassedViewStates), String(describing: [expectedViewState]))
    }

    func test_presentToolsResponse_whenResponseIsEmpty_shouldCallCorrectMethodInViewController() {
        // Given
        let viewControllerSpy = HomeDisplayLogicSpy()
        let sut = makeSUT(viewController: viewControllerSpy)
        let expectedViewState = Home.UsefulTools.ViewState.empty

        // When
        sut.presentToolsResponse(.empty)

        // Then
        XCTAssertEqual(String(describing: viewControllerSpy.displayUsefulToolsViewStatePassedViewStates), String(describing: [expectedViewState]))
    }

    func test_presentURL_shouldCallCorrectMethodInViewController() {
        // Given
        let viewControllerSpy = HomeDisplayLogicSpy()
        let sut = makeSUT(viewController: viewControllerSpy)
        // swiftlint:disable:next force_unwrapping
        let anyURL = URL(string: "https://any-url.com")!

        // When
        sut.presentURL(anyURL)

        // Then
        XCTAssertEqual(viewControllerSpy.displayURLPassedURLs, [anyURL])
    }

    func test_presentAddNewToolSuccessMessage_shouldCallCorrectMethodInViewController() {
        // Given
        let viewControllerSpy = HomeDisplayLogicSpy()
        let sut = makeSUT(viewController: viewControllerSpy)

        // When
        sut.presentAddNewToolSuccessMessage()

        // Then
        XCTAssertTrue(viewControllerSpy.displayAddNewToolSuccessMessageCalled)
    }

    func test_presentRemoveToolSuccessMessage_shouldCallCorrectMethodInViewController() {
        // Given
        let viewControllerSpy = HomeDisplayLogicSpy()
        let sut = makeSUT(viewController: viewControllerSpy)

        // When
        sut.presentRemoveToolSuccessMessage()

        // Then
        XCTAssertTrue(viewControllerSpy.displayRemoveToolSuccessMessageCalled)
    }

    // MARK: - Test Helpers

    private func makeSUT(
        viewController: HomeDisplayLogic = HomeDisplayLogicDummy(),
        file: StaticString = #file,
        line: UInt = #line
    ) -> HomePresenter {
        let sut = HomePresenter()
        sut.viewController = viewController
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(viewController, file: file, line: line)
        return sut
    }

}
