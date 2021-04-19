//
//  CustomTextViewTests.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 23/02/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import VeryUsefulToolstoRemember

final class CustomTextViewTests: XCTestCase {

    func test_customTextView() {
        let view = makeView()
        assertSnapshot(matching: view, as: .image)
    }

    func test_customTextView_errorState() {
        let view = makeView()
        view.errorMessageText = "Test"
        view.presentError()
        assertSnapshot(matching: view, as: .image)
    }

    func test_customTextView_resetView() {
        let view = makeView()
        view.errorMessageText = "Test"
        view.presentError()
        view.resetView()
        assertSnapshot(matching: view, as: .image)
    }

    func test_customTextView_didBeginEditing() {
        let view = makeView()
        view.textViewDidBeginEditing(.init())
        assertSnapshot(matching: view, as: .image)
    }

    func test_customTTextView_didEndEditing() {
        let view = makeView()
        view.textViewDidBeginEditing(.init())
        view.textViewDidEndEditing(.init())
        assertSnapshot(matching: view, as: .image)
    }

    // MARK: - Test Helpers

    private func makeView() -> CustomTextView {
        let view = CustomTextView(titleText: "Input here")
        view.frame = .init(origin: .zero, size: CGSize(width: 100, height: 100))
        return view
    }

}
