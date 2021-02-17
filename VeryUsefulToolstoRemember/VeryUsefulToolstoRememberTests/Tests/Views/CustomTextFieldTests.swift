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
    
    // MARK: - Test Helpers
    
    private func makeView() -> CustomTextField {
        let view = CustomTextField()
        view.frame = .init(origin: .zero, size: CGSize(width: 100, height: 50))
        return view
    }

}
