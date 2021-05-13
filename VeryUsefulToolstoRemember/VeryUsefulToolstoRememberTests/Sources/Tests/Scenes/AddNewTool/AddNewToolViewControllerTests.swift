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
        navigationController.viewControllers.removeAll()
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

    func test_onTappedAddToolButtonClosure_shouldCallCorrectMethodInInteractor() {
        // Given
        let interactorSpy = AddNewToolInteractorSpy()
        let sut = makeSUT(interactor: interactorSpy)
        let expectedRequest = AddNewTool.Request.mock
        guard let contentView = sut.view as? AddNewToolContentView else {
            XCTFail("Could not find contentView.")
            return
        }
        let onTappedAddToolButtonClosure = Mirror(reflecting: contentView).firstChild(of: ((AddNewTool.Request) -> Void).self, in: "onTappedAddToolButtonClosure")

        // When
        onTappedAddToolButtonClosure?(.mock)

        // Then
        XCTAssertEqual(String(describing: interactorSpy.handleNewToolCreationPassedRequests), String(describing: [expectedRequest]))
    }

    func test_displayAddToolViewState_whenStateIsLoading_shouldCallCorrectMethodInContentView() {
        // Given
        let contentViewSpy = AddNewToolContentViewSpy()
        let sut = makeSUT()
        sut.contentView = contentViewSpy

        // When
        sut.displayAddToolViewState(.loading)

        // Then
        XCTAssertEqual(String(describing: contentViewSpy.setupLoadingStatePassedBooleans), String(describing: [true]))
    }

    func test_displayAddToolViewState_whenStateIsSuccess_shouldCallCorrectMethodInContentView() {
        // Given
        let routerSpy = AddNewToolRouterSpy()
        let contentViewSpy = AddNewToolContentViewSpy()
        let sut = makeSUT(router: routerSpy)
        sut.contentView = contentViewSpy

        // When
        sut.displayAddToolViewState(.success)

        // Then
        XCTAssertEqual(String(describing: contentViewSpy.setupLoadingStatePassedBooleans), String(describing: [false]))
        XCTAssertTrue(routerSpy.routeToPreviousSceneCalled)
    }

    func test_displayAddToolViewState_whenStateIsError_shouldCallCorrectMethodInContentView() {
        // Given
        let contentViewSpy = AddNewToolContentViewSpy()
        let sut = makeSUT()
        sut.contentView = contentViewSpy

        // When
        sut.displayAddToolViewState(.error)

        // Then
        XCTAssertEqual(String(describing: contentViewSpy.setupLoadingStatePassedBooleans), String(describing: [false]))
    }

    // MARK: - Private Methods

    private func makeSUT(
        interactor: AddNewToolBusinessLogic = AddNewToolInteractorDummy(),
        router: AddNewToolRoutingLogic = AddNewToolRouterDummy(),
        mainDispatchQueue: DispatchQueueType = DispatchQueueTypeMock(),
        file: StaticString = #file,
        line: UInt = #line
    ) -> AddNewToolViewController {
        let sut = AddNewToolViewController(interactor: interactor, router: router, mainDispatchQueue: mainDispatchQueue)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }

}
