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

    // MARK: - Test Helpers
    
    private func makeSUT(viewController: HomeDisplayLogic = HomeDisplayLogicDummy()) -> HomePresenter {
        let sut = HomePresenter()
        sut.viewController = viewController
        return sut
    }

}

final class HomeDisplayLogicDummy: HomeDisplayLogic {
    func displayUsefulToolsViewState(_ viewState: Home.UsefulTools.ViewState) {}
}

final class HomeDisplayLogicSpy: HomeDisplayLogic {
    
    private(set) var displayUsefulToolsViewStatePassedViewStates = [Home.UsefulTools.ViewState]()
    
    func displayUsefulToolsViewState(_ viewState: Home.UsefulTools.ViewState) {
        displayUsefulToolsViewStatePassedViewStates.append(viewState)
    }
}

extension GetUsefulToolsUseCaseModels.Tool {
    static var mock: GetUsefulToolsUseCaseModels.Tool {
        .init(
            id: 1,
            title: "Notion",
            link: "",
            description: "All in one too to organize teams and ideas. Write, plan, collaborate, and get organized.",
            tags: ["#organization", "#planning", "#collaboration", "#writing"]
        )
    }
}
