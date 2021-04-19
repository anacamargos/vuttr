//
//  HomeConfiguratorTests.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 18/02/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import XCTest
@testable import VeryUsefulToolstoRemember

final class HomeConfiguratorTests: XCTestCase {

    func test_configurator_shouldReturnCorrectlyConfiguredInstance() {
        // Given
        let sut = HomeConfigurator()
        trackForMemoryLeaks(sut)

        // When
        let viewController = sut.resolveViewController()

        // Then
        guard let router = Mirror(reflecting: viewController).firstChild(of: HomeRouter.self) else {
            XCTFail("Could not find HomeRouter.")
            return
        }
        guard let interactor = Mirror(reflecting: viewController).firstChild(of: HomeInteractor.self) else {
            XCTFail("Could not find HomeInteractor.")
            return
        }
        guard let presenter = Mirror(reflecting: interactor).firstChild(of: HomePresenter.self) else {
            XCTFail("Could not find HomePresenter.")
            return
        }

        XCTAssertNotNil(router.viewController)
        XCTAssertTrue(router.viewController is HomeViewController)
        XCTAssertNotNil(presenter.viewController)
        XCTAssertTrue(presenter.viewController is HomeViewController)
    }

}
