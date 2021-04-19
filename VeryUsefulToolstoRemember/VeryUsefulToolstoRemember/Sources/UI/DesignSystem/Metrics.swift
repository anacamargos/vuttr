//
//  Metrics.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 23/12/20.
//

import UIKit

enum Metrics {
    enum Spacing {
        /// CGFloat = 4
        static let tiny: CGFloat = 4
        /// CGFloat = 8
        static let xSmall: CGFloat = 8
        /// CGFloat = 16
        static let small: CGFloat = 16
        /// CGFloat = 24
        static let base: CGFloat = 24
        /// CGFloat = 32
        static let medium: CGFloat = 32
        /// CGFloat = 48
        static let large: CGFloat = 48
        /// CGFloat = 64
        static let xLarge: CGFloat = 64
    }
}

extension Metrics {
    enum FontSize {
        case header
        case title
        case subtitle
        case body
        case caption

        var value: CGFloat {
            switch self {
            case .header:
                return 30
            case .title:
                return 24
            case .subtitle:
                return 18
            case .body:
                return 14
            case .caption:
                return 12
            }
        }
    }
}
