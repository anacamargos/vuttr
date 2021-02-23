//
//  AddNewToolConfiguratorTests.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 23/02/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import XCTest
@testable import VeryUsefulToolstoRemember

final class AddNewToolConfiguratorTests: XCTestCase {

    func test_configurator_shouldReturnCorrectlyConfiguredInstance() {
        // Given
        let sut = AddNewToolConfigurator()
        
        // When
        let viewController = sut.resolveViewController()
        
        // Then
        guard let router = Mirror(reflecting: viewController).firstChild(of: AddNewToolRouter.self) else {
            XCTFail("Could not find HomeRouter.")
            return
        }
        
        XCTAssertNotNil(router.viewController)
        XCTAssertTrue(router.viewController is AddNewToolViewController)
    }

}
