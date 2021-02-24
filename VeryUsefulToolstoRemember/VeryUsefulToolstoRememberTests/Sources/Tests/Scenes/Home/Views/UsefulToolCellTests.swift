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

extension Home.UsefulTools.Tool {
    static var mock: Home.UsefulTools.Tool {
        .init(
            title: "Notion",
            description: "All in one too to organize teams and ideas. Write, plan, collaborate, and get organized.",
            tags: [
                .init(text: "#organization", estimatedWidth: getEstimatedWidthByWord("#organization")),
                .init(text: "#planning", estimatedWidth: getEstimatedWidthByWord("#planning")),
                .init(text: "#collaboration", estimatedWidth: getEstimatedWidthByWord("#collaboration")),
                .init(text: "#writing", estimatedWidth: getEstimatedWidthByWord("#writing"))
            ]
        )
    }
    
    private static func getEstimatedWidthByWord(_ word: String) -> CGFloat {
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Metrics.FontSize.body.value)]
        let estimatedWidth = NSString(string: word).boundingRect(with: .zero, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return estimatedWidth.width
    }
}
