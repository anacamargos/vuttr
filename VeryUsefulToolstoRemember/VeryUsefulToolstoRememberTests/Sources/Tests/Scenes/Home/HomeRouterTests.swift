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
    
    // MARK: - Test Helpers
    
    private func makeSUT() -> HomeRouter {
        .init(addNewToolConfigurator: .init())
    }
    
    private func makeViewController(_ sut: HomeRouter) -> UIViewControllerSpy {
        let viewController = UIViewControllerSpy()
        sut.viewController = viewController
        return viewController
    }

}
