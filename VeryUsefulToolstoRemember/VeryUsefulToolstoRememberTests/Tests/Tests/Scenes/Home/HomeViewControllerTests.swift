//
//  HomeViewControllerTests.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 17/02/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import VeryUsefulToolstoRemember

final class HomeViewControllerTests: XCTestCase {
    
    func test_homeViewController() {
        let viewController = makeSUT()
        let navigationController = UINavigationController(rootViewController: viewController)
        viewController.viewDidLoad()
        viewController.loadView()
        viewController.viewWillAppear(true)
        viewController.displayUsefulToolsViewState(.content(.init(tools: [.mock, .mock])))
        assertSnapshot(matching: navigationController, as: .image(on: .iPhone8))
    }
    
    func test_displayUsefulToolsViewState_shouldCallCorrectMethodInContentView() {
        // Given
        let contentViewSpy = HomeContentViewSpy()
        let sut = makeSUT()
        sut.contentView = contentViewSpy
        let expectedViewState = Home.UsefulTools.ViewState.loading
        
        // When
        sut.displayUsefulToolsViewState(.loading)
        
        // Then
        XCTAssertEqual(String(describing: contentViewSpy.setupUsefulToolsStatePassedViewStates), String(describing: [expectedViewState]))
    }

    // MARK: - Private Methods
    
    private func makeSUT() -> HomeViewController {
        let sut = HomeViewController()
        return sut
    }
}
