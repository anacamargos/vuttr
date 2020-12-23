//
//  UIFontExtensions.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 23/12/20.
//

import UIKit

extension UIFont {
    
    /// Static function that creates a Montserrat Alternates font
    ///
    /// - Parameters:
    ///   - fontSize: Font size
    ///   - weight: Font weight
    /// - Returns: Montserrat Alternates Font with specified parameters
    class func themeFont(ofSize fontSize: CGFloat, weight: UIFont.MontserratAlternates) -> UIFont {

        guard let montserratAlternates = UIFont(name: weight.fontName, size: fontSize) else {
            debugPrint("Failed to load Montserrat Alternates Font.")
            return UIFont.systemFont(ofSize: fontSize, weight: weight.asUIFontWeight)
        }

        return montserratAlternates
    }

    /// Static function that creates a Montserrat Alternates font
    ///
    /// - Parameters:
    ///   - metricsSize: Font size based on the Metrics enum
    ///   - weight: Font weight
    /// - Returns: Montserrat Alternates Font with specified parameters
    class func themeFont(
        for metricsSize: Metrics.FontSize,
        weight: UIFont.MontserratAlternates
    ) -> UIFont {
        .themeFont(ofSize: metricsSize.value, weight: weight)
    }
}

extension UIFont {
    /// Defines font weight
    ///
    /// - regular: Regular weight
    /// - semibold: SemiBold Font
    enum MontserratAlternates {
        
        // MARK: - Types
        
        case regular
        case semibold
        
        // MARK: - Internal Properties
        
        fileprivate var fontName: String {
            switch self {
            case .regular:
                return "SourceSansPro-Regular"
            case .semibold:
                return "SourceSansPro-SemiBold"
            }
        }
        
        fileprivate var asUIFontWeight: UIFont.Weight {
            switch self {
            case .regular:
                return .regular
            case .semibold:
                return .semibold
            }
        }
    }
}

