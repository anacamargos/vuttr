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
    
    func test_onTappedAddButtonClosure_shouldCallCorrectMethodInRouter() {
        // Given
        let routerSpy = HomeRouterSpy()
        let sut = makeSUT(router: routerSpy)
        guard let contentView = sut.view as? HomeContentView else {
            XCTFail("Could not find contentView.")
            return
        }
        let onTappedAddButtonClosure = Mirror(reflecting: contentView).firstChild(of: (() -> Void).self, in: "onTappedAddButtonClosure")
        
        // When
        onTappedAddButtonClosure?()
        
        // Then
        XCTAssertTrue(routerSpy.routeToAddNewToolSceneCalled)
    }
    
    func test_displayURL_shouldCallCorrectMethodInRouter() {
        // Given
        let routerSpy = HomeRouterSpy()
        let sut = makeSUT(router: routerSpy)
        let anyURL = URL(string: "https://any-url.com")!
        
        // When
        sut.displayURL(anyURL)
        
        // Then
        XCTAssertEqual(routerSpy.routeToURLPassedURLs, [anyURL])
    }
    
    func test_onTappedToolCellClosure_shouldCallCorrectMethodInInteractor() {
        // Given
        let interactorSpy = HomeInteractorSpy()
        let sut = makeSUT(interactor: interactorSpy)
        guard let contentView = sut.view as? HomeContentView else {
            XCTFail("Could not find contentView.")
            return
        }
        let onTappedToolCellClosure = Mirror(reflecting: contentView).firstChild(of: ((Int) -> Void).self, in: "onTappedToolCellClosure")
        
        // When
        onTappedToolCellClosure?(.zero)
        
        // Then
        XCTAssertTrue(interactorSpy.handleToolSelectionCalled)
    }
    
    func test_viewDidLoad_shouldCallCorrectMethodInInteractor() {
        // Given
        let interactorSpy = HomeInteractorSpy()
        let sut = makeSUT(interactor: interactorSpy)
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertTrue(interactorSpy.onViewDidLoadCalled)
    }
    
    func test_onTappedRemoveToolAction_shouldCallCorrectMethodInRouterAndInteractor() {
        // Given
        let routerSpy = HomeRouterSpy()
        let interactorSpy = HomeInteractorSpy()
        let sut = makeSUT(interactor: interactorSpy, router: routerSpy)
        guard let contentView = sut.view as? HomeContentView else {
            XCTFail("Could not find contentView.")
            return
        }
        let onTappedRemoveToolClosure = Mirror(reflecting: contentView).firstChild(of: ((UInt) -> Void).self, in: "onTappedRemoveToolClosure")
        
        // When
        onTappedRemoveToolClosure?(.zero)
        
        // Then
        XCTAssertTrue(routerSpy.routeToRemoveToolSceneCalled)
    }

    // MARK: - Private Methods
    
    private func makeSUT(
        interactor: HomeBusinessLogic = HomeInteractorDummy(),
        router: HomeRoutingLogic = HomeRouterDummy()
    ) -> HomeViewController {
        let sut = HomeViewController(interactor: interactor, router: router)
        return sut
    }
}
