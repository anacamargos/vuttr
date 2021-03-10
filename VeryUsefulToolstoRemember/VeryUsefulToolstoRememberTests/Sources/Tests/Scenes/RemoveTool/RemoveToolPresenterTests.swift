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

    // MARK: - Test Helpers
    
    private func makeSUT(viewController: RemoveToolDisplayLogic = RemoveToolDisplayLogicDummy()) -> RemoveToolPresenter {
        let sut = RemoveToolPresenter()
        sut.viewController = viewController
        return sut
    }

}
