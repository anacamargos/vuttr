//
//  HomeContentViewTests.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 29/12/20.
//  Copyright © 2020 Ana Letícia Camargos. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import VeryUsefulToolstoRemember

final class HomeContentViewTests: XCTestCase {

    func test_homeContentView_loadingState() {
        let view = makeView()
        view.setupUsefulToolsState(.loading)
        assertSnapshot(matching: view, as: .image)
    }

    func test_homeContentView_contentState() {
        let view = makeView()
        view.setupUsefulToolsState(.content(.init(tools: [.mock, .mock, .mock])))
        assertSnapshot(matching: view, as: .image)
    }

    func test_homeContentView_emptyState() {
        let view = makeView()
        view.setupUsefulToolsState(.empty)
        assertSnapshot(matching: view, as: .image)
    }

    func test_homeContentView_errorState() {
        let view = makeView()
        view.setupUsefulToolsState(.error)
        assertSnapshot(matching: view, as: .image)
    }

    // MARK: - Test Helpers

    private func makeView() -> HomeContentView {
        return .init(frame: CGRect(origin: .zero, size: CGSize(width: 300, height: 500)), onTappedAddButtonClosure: {}, onTappedToolCellClosure: { _ in }, onTappedRemoveToolClosure: { _ in }, onTappedErrorReloadButtonClosure: {})
    }

}
