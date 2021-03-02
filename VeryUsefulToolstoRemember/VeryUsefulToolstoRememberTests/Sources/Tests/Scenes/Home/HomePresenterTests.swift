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
    
    func test_presentURL_shouldCallCorrectMethodInViewController() {
        // Given
        let viewControllerSpy = HomeDisplayLogicSpy()
        let sut = makeSUT(viewController: viewControllerSpy)
        let anyURL = URL(string: "https://any-url.com")!
        
        // When
        sut.presentURL(anyURL)
        
        // Then
        XCTAssertEqual(viewControllerSpy.displayURLPassedURLs, [anyURL])
    }

    // MARK: - Test Helpers
    
    private func makeSUT(viewController: HomeDisplayLogic = HomeDisplayLogicDummy()) -> HomePresenter {
        let sut = HomePresenter()
        sut.viewController = viewController
        return sut
    }

}
