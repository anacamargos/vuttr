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

    func test_onTappedRemoveToolButtonClosure_shouldCallCorrectMethodInInteractor() {
        // Given
        let interactorSpy = RemoveToolInteractorSpy()
        let sut = makeSUT(interactor: interactorSpy)
        guard let contentView = sut.view as? RemoveToolContentView else {
            XCTFail("Could not find contentView.")
            return
        }
        let onTappedRemoveToolButtonClosure = Mirror(reflecting: contentView).firstChild(of: (() -> Void).self, in: "onTappedRemoveToolButtonClosure")

        // When
        onTappedRemoveToolButtonClosure?()

        // Then
        XCTAssertTrue(interactorSpy.handleRemoveToolActionCalled)
    }

    func test_displayDeleteToolViewState_whenStateIsSuccess_shouldCallCorrectMethods() {
        // Given
        let contentViewSpy = RemoveToolContentViewSpy()
        let routerSpy = RemoveToolRouterSpy()
        let sut = makeSUT(router: routerSpy)
        sut.contentView = contentViewSpy

        // When
        sut.displayDeleteToolViewState(.success)

        // Then
        XCTAssertEqual(String(describing: contentViewSpy.setupLoadingStatePassedBooleans), String(describing: [false]))
        XCTAssertTrue(routerSpy.routeToPreviousSceneCalled)
    }

    func test_displayDeleteToolViewState_whenStateIsLoading_shouldCallCorrectMethods() {
        // Given
        let contentViewSpy = RemoveToolContentViewSpy()
        let sut = makeSUT()
        sut.contentView = contentViewSpy

        // When
        sut.displayDeleteToolViewState(.loading)

        // Then
        XCTAssertEqual(String(describing: contentViewSpy.setupLoadingStatePassedBooleans), String(describing: [true]))
    }

    func test_displayDeleteToolViewState_whenStateIsError_shouldCallCorrectMethods() {
        // Given
        let contentViewSpy = RemoveToolContentViewSpy()
        let sut = makeSUT()
        sut.contentView = contentViewSpy

        // When
        sut.displayDeleteToolViewState(.error)

        // Then
        XCTAssertEqual(String(describing: contentViewSpy.setupLoadingStatePassedBooleans), String(describing: [false]))
    }

    // MARK: - Private Methods

    private func makeSUT(
        interactor: RemoveToolBusinessLogic = RemoveToolInteractorDummy(),
        router: RemoveToolRoutingLogic = RemoveToolRouterDummy(),
        mainDispatchQueue: DispatchQueueType = DispatchQueueTypeMock()
    ) -> RemoveToolViewController {
        let sut = RemoveToolViewController(interactor: interactor, router: router, mainDispatchQueue: mainDispatchQueue)
        return sut
    }
}

final class DispatchQueueTypeMock: DispatchQueueType {
    func async(execute work: @escaping () -> Void) {
        work()
    }
}
