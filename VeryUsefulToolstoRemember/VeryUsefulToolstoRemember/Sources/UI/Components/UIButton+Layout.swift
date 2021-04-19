//
//  UIButton+Layout.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 19/02/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import UIKit

/// Defines the button layout configuration
struct ButtonLayout: Equatable {
    let enabled: Properties
    let disabled: Properties

    init(
        enabled: Properties,
        disabled: Properties
    ) {
        self.enabled = enabled
        self.disabled = disabled
    }

    struct Properties: Equatable {
        let titleFont: UIFont
        let titleColor: UIColor
        let borderColor: UIColor?
        let borderWidth: CGFloat?
        let backgroundColor: UIColor
        let selectedBackgroundColor: UIColor?
        let cornerRadius: CGFloat

        init(
            titleFont: UIFont,
            titleColor: UIColor,
            borderColor: UIColor? = nil,
            borderWidth: CGFloat? = nil,
            backgroundColor: UIColor,
            selectedBackgroundColor: UIColor? = nil,
            cornerRadius: CGFloat = 4
        ) {
            self.titleFont = titleFont
            self.titleColor = titleColor
            self.borderColor = borderColor
            self.borderWidth = borderWidth
            self.backgroundColor = backgroundColor
            self.selectedBackgroundColor = selectedBackgroundColor
            self.cornerRadius = cornerRadius
        }
    }
}

extension UIButton {
    /// Applies a the layout  to a UIButton
    /// - Parameter layout: a layout definition with properties to decorate a button
    @discardableResult
    func applyLayout(_ layout: ButtonLayout) -> Self {
        let propertiesToApply = isEnabled ? layout.enabled : layout.disabled
        applyLayoutProperties(propertiesToApply)
        return self
    }

    /// Applies a the layout properties to a UIButton
    /// - Parameter layout: a layout definition with properties to decorate a button
    @discardableResult
    func applyLayoutProperties(_ properties: ButtonLayout.Properties) -> Self {
        titleLabel?.font = properties.titleFont
        setTitleColor(properties.titleColor, for: .normal)
        layer.borderColor = properties.borderColor?.cgColor
        if let borderWidth = properties.borderWidth { layer.borderWidth = borderWidth }
        backgroundColor = properties.backgroundColor
        layer.cornerRadius = properties.cornerRadius
        return self
    }
}
