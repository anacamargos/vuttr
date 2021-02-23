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
    
    // MARK: - Private Methods
    
    private func makeSUT(router: AddNewToolRoutingLogic = AddNewToolRouterDummy()) -> AddNewToolViewController {
        let sut = AddNewToolViewController(router: router)
        return sut
    }

}
