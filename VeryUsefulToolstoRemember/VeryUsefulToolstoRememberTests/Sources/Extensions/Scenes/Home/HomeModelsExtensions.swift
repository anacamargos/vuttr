//
//  HomeModelsExtensions.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 01/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import UIKit
@testable import VeryUsefulToolstoRemember

extension Home.UsefulTools.Tool {
    static var mock: Home.UsefulTools.Tool {
        .init(
            id: .zero,
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
