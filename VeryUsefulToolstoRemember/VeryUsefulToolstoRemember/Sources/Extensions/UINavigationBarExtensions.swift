//
//  UINavigationBarExtensions.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 23/12/20.
//

import UIKit

extension UINavigationBar {
    func configure(
        customBackgroundColor: UIColor = .white,
        smallTitleSize: Metrics.FontSize = .subtitle,
        largeTitleSize: Metrics.FontSize = .title,
        titleWeight: UIFont.SourceSansPro = .semibold,
        titleColor: UIColor = .black
    ) {
        titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.themeFont(for: smallTitleSize, weight: titleWeight),
            NSAttributedString.Key.foregroundColor: titleColor
        ]
        largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont.themeFont(for: smallTitleSize, weight: titleWeight),
            NSAttributedString.Key.foregroundColor: titleColor,
        ]
        backgroundColor = customBackgroundColor
        barTintColor = customBackgroundColor
        isTranslucent = false
        shadowImage = .init()
        setBackgroundImage(nil, for: .default)
    }
}
