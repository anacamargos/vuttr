//
//  RemoveToolViewControllerTests.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 12/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import VeryUsefulToolstoRemember

final class RemoveToolViewControllerTests: XCTestCase {

    func test_removeToolViewController() {
        let viewController = makeSUT()
        let navigationController = UINavigationController(rootViewController: viewController)
        viewController.viewDidLoad()
        viewController.loadView()
        viewController.displayToolName("Notion")
        assertSnapshot(matching: navigationController, as: .image(on: .iPhone8))
    }
    
    func test_viewDidLoad_shouldCallCorrectMethodInInteractor() {
        // Given
        let interactorSpy = RemoveToolInteractorSpy()
        let sut = makeSUT(interactor: interactorSpy)
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertTrue(interactorSpy.onViewDidLoadCalled)
    }
    // MARK: - Private Methods
    
    private func makeSUT(
        interactor: RemoveToolBusinessLogic = RemoveToolInteractorDummy(),
        router: RemoveToolRoutingLogic = RemoveToolRouterDummy()
    ) -> RemoveToolViewController {
        let sut = RemoveToolViewController(interactor: interactor, router: router)
        return sut
    }
}

final class RemoveToolInteractorDummy: RemoveToolBusinessLogic {
    func onViewDidLoad() {}
}

final class RemoveToolRouterDummy: RemoveToolRoutingLogic {
    func routeToPreviousScene() {}
}

final class RemoveToolInteractorSpy: RemoveToolBusinessLogic {
    
    private(set) var onViewDidLoadCalled = false
    
    func onViewDidLoad() {
        onViewDidLoadCalled = true
    }
}
