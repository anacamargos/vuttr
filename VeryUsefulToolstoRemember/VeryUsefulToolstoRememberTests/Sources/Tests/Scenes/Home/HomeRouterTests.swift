//
//  HomeRouterTests.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 23/02/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import XCTest
import SafariServices
@testable import VeryUsefulToolstoRemember

final class HomeRouterTests: XCTestCase {

    func test_routeToAddNewToolScene_shouldPresentCorrectViewController() {
        // Given
        let sut = makeSUT()
        let viewControllerSpy = makeViewController(sut)
        
        // When
        sut.routeToAddNewToolScene()
        
        // Then
        guard let passedViewController = viewControllerSpy.viewControllerToPresentPassed else {
            XCTFail("Could not find viewControllerToPresentPassed")
            return
        }
        guard let passedAnimatedFlag = viewControllerSpy.presentAnimatedFlagPassed else {
            XCTFail("Could not find presentAnimatedFlagPassed")
            return
        }
        XCTAssertTrue(viewControllerSpy.presentCalled)
        XCTAssertTrue(passedViewController is AddNewToolViewController)
        XCTAssertTrue(passedAnimatedFlag)
        XCTAssertNil(viewControllerSpy.presentCompletionPassed)
    }
    
    func test_routeToURL_shouldPresentCorrectViewController() {
        // Given
        let sut = makeSUT()
        let viewControllerSpy = makeViewController(sut)
        let anyURL = URL(string: "https://any-url.com")!
        
        // When
        sut.routeToURL(anyURL)
        
        // Then
        guard let passedViewController = viewControllerSpy.viewControllerToPresentPassed else {
            XCTFail("Could not find viewControllerToPresentPassed")
            return
        }
        guard let passedAnimatedFlag = viewControllerSpy.presentAnimatedFlagPassed else {
            XCTFail("Could not find presentAnimatedFlagPassed")
            return
        }
        XCTAssertTrue(viewControllerSpy.presentCalled)
        XCTAssertTrue(passedViewController is SFSafariViewController)
        XCTAssertTrue(passedAnimatedFlag)
        XCTAssertNil(viewControllerSpy.presentCompletionPassed)
    }
    
    func test_routeToRemoveToolScene_whenSelectedToolIsNotNil_shouldPresentCorrectViewController() {
        // Given
        let sut = makeSUT()
        let viewControllerSpy = makeViewController(sut)
        
        // When
        sut.routeToRemoveToolScene()
        
        // Then
        guard let passedViewController = viewControllerSpy.viewControllerToPresentPassed else {
            XCTFail("Could not find viewControllerToPresentPassed")
            return
        }
        guard let passedAnimatedFlag = viewControllerSpy.presentAnimatedFlagPassed else {
            XCTFail("Could not find presentAnimatedFlagPassed")
            return
        }
        XCTAssertTrue(viewControllerSpy.presentCalled)
        XCTAssertTrue(passedViewController is RemoveToolViewController)
        XCTAssertTrue(passedAnimatedFlag)
        XCTAssertNil(viewControllerSpy.presentCompletionPassed)
    }
    
    func test_routeToRemoveToolScene_whenSelectedToolIsNil_shouldNotPresentCorrectViewController() {
        // Given
        var dataStore = HomeDataStoreDummy()
        dataStore.selectedTool = nil
        let sut = makeSUT(dataStore: dataStore)
        let viewControllerSpy = makeViewController(sut)
        
        // When
        sut.routeToRemoveToolScene()
        
        // Then
        XCTAssertFalse(viewControllerSpy.presentCalled)
        XCTAssertNil(viewControllerSpy.viewControllerToPresentPassed)
        XCTAssertNil(viewControllerSpy.presentAnimatedFlagPassed)
        XCTAssertNil(viewControllerSpy.presentCompletionPassed)
    }
    
    // MARK: - Test Helpers
    
    private func makeSUT(
        dataStore: HomeDataStore = HomeDataStoreDummy(),
        file: StaticString = #file,
        line: UInt = #line
    ) -> HomeRouter {
        let sut = HomeRouter(
            addNewToolConfigurator: .init(),
            removeToolConfigurator: .init(),
            dataStore: dataStore
        )
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
    
    private func makeViewController(_ sut: HomeRouter) -> UIViewControllerSpy {
        let viewController = UIViewControllerSpy()
        sut.viewController = viewController
        return viewController
    }

}

struct HomeDataStoreDummy: HomeDataStore {
    var selectedTool: GetUsefulToolsUseCaseModels.Tool? = .mock
}
