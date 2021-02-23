//
//  AddNewToolViewControllerTests.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 23/02/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import VeryUsefulToolstoRemember

final class AddNewToolViewControllerTests: XCTestCase {

    func test_addNewToolViewController() {
        let viewController = makeSUT()
        let navigationController = UINavigationController(rootViewController: viewController)
        viewController.viewDidLoad()
        viewController.loadView()
        assertSnapshot(matching: navigationController, as: .image(on: .iPhone8))
    }
    
    func test_onTappedCloseButtonAction_shouldCallCorrectMethodInRouter() {
        // Given
        let routerSpy = AddNewToolRouterSpy()
        let sut = makeSUT(router: routerSpy)
        guard let contentView = sut.view as? AddNewToolContentView else {
            XCTFail("Could not find contentView.")
            return
        }
        let onTappedCloseButtonClosure = Mirror(reflecting: contentView).firstChild(of: (() -> Void).self, in: "onTappedCloseButtonClosure")
        
        // When
        onTappedCloseButtonClosure?()
        
        // Then
        XCTAssertTrue(routerSpy.routeToPreviousSceneCalled)
    }
    
    // MARK: - Private Methods
    
    private func makeSUT(router: AddNewToolRoutingLogic = AddNewToolRouterDummy()) -> AddNewToolViewController {
        let sut = AddNewToolViewController(router: router)
        return sut
    }

}

final class AddNewToolRouterSpy: AddNewToolRoutingLogic {
    
    private(set) var routeToPreviousSceneCalled = false
    
    func routeToPreviousScene() {
        routeToPreviousSceneCalled = true
    }
}
