//
//  RemoveToolContentViewTests.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 08/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import VeryUsefulToolstoRemember

final class RemoveToolContentViewTests: XCTestCase {
    
    func test_removeToolContentView() {
        let view = makeView()
        view.setupViewData("Notion")
        assertSnapshot(matching: view, as: .image, record: true)
    }

    // MARK: - Test Helpers
    
    private func makeView() -> RemoveToolContentView {
        return .init(
            frame: .init(origin: .zero, size: CGSize(width: 350, height: 600))
        )
    }

}
