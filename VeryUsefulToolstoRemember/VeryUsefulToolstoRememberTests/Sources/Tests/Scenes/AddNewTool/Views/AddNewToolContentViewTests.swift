//
//  AddNewToolContentViewTests.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 23/02/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import VeryUsefulToolstoRemember

final class AddNewToolContentViewTests: XCTestCase {
    
    func test_addNewToolContentView() {
        let view = makeView()
        assertSnapshot(matching: view, as: .image)
    }

    // MARK: - Test Helpers
    
    private func makeView() -> AddNewToolContentView {
        return .init(
            frame: .init(origin: .zero, size: CGSize(width: 350, height: 600)),
            onTappedCloseButtonClosure: {},
            onTappedAddToolButtonClosure: { _ in }
        )
    }

}
