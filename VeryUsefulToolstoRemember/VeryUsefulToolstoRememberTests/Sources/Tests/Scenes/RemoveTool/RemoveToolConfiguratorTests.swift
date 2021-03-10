//
//  RemoveToolConfiguratorTests.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 10/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import XCTest
@testable import VeryUsefulToolstoRemember

final class RemoveToolConfiguratorTests: XCTestCase {

    func test_configurator_shouldReturnCorrectlyConfiguredInstance() {
        // Given
        let sut = RemoveToolConfigurator()
        
        // When
        let viewController = sut.resolveViewController(using: .init(toolName: "", toolId: .zero))
        
        // Then
        guard let router = Mirror(reflecting: viewController).firstChild(of: RemoveToolRouter.self) else {
            XCTFail("Could not find RemoveToolRouter.")
            return
        }
        guard let interactor = Mirror(reflecting: viewController).firstChild(of: RemoveToolInteractor.self) else {
            XCTFail("Could not find RemoveToolInteractor.")
            return
        }
        guard let presenter = Mirror(reflecting: interactor).firstChild(of: RemoveToolPresenter.self) else {
            XCTFail("Could not find RemoveToolPresenter.")
            return
        }
        
        XCTAssertNotNil(router.viewController)
        XCTAssertTrue(router.viewController is RemoveToolViewController)
        XCTAssertNotNil(presenter.viewController)
        XCTAssertTrue(presenter.viewController is RemoveToolViewController)
    }
}
