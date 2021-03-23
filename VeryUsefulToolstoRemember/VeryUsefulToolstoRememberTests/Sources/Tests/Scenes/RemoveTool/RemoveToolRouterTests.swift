//
//  RemoveToolRouterTests.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 10/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import XCTest
@testable import VeryUsefulToolstoRemember

final class RemoveToolRouterTests: XCTestCase {

    func test_routeToPreviousScene_shouldDismissViewController() {
        // Given
        let sut = makeSUT()
        let viewControllerSpy = makeViewController(sut)
        
        // When
        sut.routeToPreviousScene()
        
        // Then
        guard let passedAnimatedFlag = viewControllerSpy.dismissAnimatedFlagPassed else {
            XCTFail("Could not find dismissAnimatedFlagPassed")
            return
        }
        XCTAssertTrue(viewControllerSpy.dismissCalled)
        XCTAssertTrue(passedAnimatedFlag)
        XCTAssertNil(viewControllerSpy.dismissCompletionPassed)
    }

    // MARK: - Test Helpers
    
    private func makeSUT(
        file: StaticString = #file,
        line: UInt = #line
    ) -> RemoveToolRouter {
        let sut = RemoveToolRouter()
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
    
    private func makeViewController(
        _ sut: RemoveToolRouter,
        file: StaticString = #file,
        line: UInt = #line
    ) -> UIViewControllerSpy {
        let viewController = UIViewControllerSpy()
        sut.viewController = viewController
        trackForMemoryLeaks(viewController, file: file, line: line)
        return viewController
    }

}
