//
//  AddNewToolRouterTests.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 23/02/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import XCTest
@testable import VeryUsefulToolstoRemember

final class AddNewToolRouterTests: XCTestCase {
    
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
    
    private func makeSUT() -> AddNewToolRouter {
        .init()
    }
    
    private func makeViewController(_ sut: AddNewToolRouter) -> UIViewControllerSpy {
        let viewController = UIViewControllerSpy()
        sut.viewController = viewController
        return viewController
    }

}
