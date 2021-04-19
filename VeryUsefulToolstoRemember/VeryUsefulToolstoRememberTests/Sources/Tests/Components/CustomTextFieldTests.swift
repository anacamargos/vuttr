//
//  CustomTextFieldTests.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 17/02/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import VeryUsefulToolstoRemember

final class CustomTextFieldTests: XCTestCase {

    func test_customTextField() {
        let view = makeView()
        assertSnapshot(matching: view, as: .image)
    }

    func test_customTextField_errorState() {
        let view = makeView()
        view.errorMessageText = "Test"
        view.presentError()
        assertSnapshot(matching: view, as: .image)
    }

    func test_customTextField_resetView() {
        let view = makeView()
        view.errorMessageText = "Test"
        view.presentError()
        view.resetView()
        assertSnapshot(matching: view, as: .image)
    }

    func test_customTextField_didBeginEditing() {
        let view = makeView()
        view.textFieldDidBeginEditing(.init())
        assertSnapshot(matching: view, as: .image)
    }

    func test_customTextField_didEndEditing() {
        let view = makeView()
        view.textFieldDidBeginEditing(.init())
        view.textFieldDidEndEditing(.init())
        assertSnapshot(matching: view, as: .image)
    }

    // MARK: - Test Helpers

    private func makeView() -> CustomTextField {
        let view = CustomTextField(titleText: "Input here")
        view.frame = .init(origin: .zero, size: CGSize(width: 100, height: 100))
        return view
    }

}
