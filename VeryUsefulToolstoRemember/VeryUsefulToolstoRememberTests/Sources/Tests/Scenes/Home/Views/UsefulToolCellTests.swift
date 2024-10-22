//
//  UsefulToolCellTests.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 29/12/20.
//  Copyright © 2020 Ana Letícia Camargos. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import VeryUsefulToolstoRemember

final class UsefulToolCellTests: XCTestCase {

    func test_usefulToolCell() {
        let view = makeView()
        view.setupViewData(.mock)
        assertSnapshot(matching: view, as: .image)
    }

    // MARK: - Test Helpers

    private func makeView() -> UsefulToolCell {
        let view = UsefulToolCell()
        view.frame = .init(origin: .zero, size: CGSize(width: 300, height: 150))
        return view
    }
}
