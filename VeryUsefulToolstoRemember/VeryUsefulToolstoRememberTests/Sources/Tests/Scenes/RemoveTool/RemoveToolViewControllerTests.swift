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

    func test_displayToolName_shouldCallCorrectMethodInContentView() {
        // Given
        let contentViewSpy = RemoveToolContentViewSpy()
        let sut = makeSUT()
        sut.contentView = contentViewSpy
        let toolName = "Notion"

        // When
        sut.displayToolName(toolName)

        // Then
        XCTAssertEqual(String(describing: contentViewSpy.setupViewDataPassedToolNames), String(describing: [toolName]))
    }

    func test_onTappedAddButtonClosure_shouldCallCorrectMethodInRouter() {
        // Given
        let routerSpy = RemoveToolRouterSpy()
        let sut = makeSUT(router: routerSpy)
        guard let contentView = sut.view as? RemoveToolContentView else {
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

    private func makeSUT(
        interactor: RemoveToolBusinessLogic = RemoveToolInteractorDummy(),
        router: RemoveToolRoutingLogic = RemoveToolRouterDummy()
    ) -> RemoveToolViewController {
        let sut = RemoveToolViewController(interactor: interactor, router: router)
        return sut
    }
}

final class RemoveToolInteractorSpy: RemoveToolBusinessLogic {

    private(set) var onViewDidLoadCalled = false

    func onViewDidLoad() {
        onViewDidLoadCalled = true
    }

    private(set) var handleRemoveToolActionCalled = false

    func handleRemoveToolAction() {
        handleRemoveToolActionCalled = true
    }
}

final class RemoveToolContentViewSpy: RemoveToolContentViewProtocol {

    private(set) var setupViewDataPassedToolNames = [String]()

    func setupViewData(_ toolName: String) {
        setupViewDataPassedToolNames.append(toolName)
    }

    private(set) var setupLoadingStatePassedBooleans = [Bool]()

    func setupLoadingState(_ isLoading: Bool) {
        setupLoadingStatePassedBooleans.append(isLoading)
    }
}

final class RemoveToolRouterSpy: RemoveToolRoutingLogic {

    private(set) var routeToPreviousSceneCalled = false

    func routeToPreviousScene() {
        routeToPreviousSceneCalled = true
    }
}
