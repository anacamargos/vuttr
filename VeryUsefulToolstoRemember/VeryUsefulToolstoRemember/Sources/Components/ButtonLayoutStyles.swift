//
//  ButtonLayoutStyles.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 19/02/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import UIKit

extension ButtonLayout {
    
    static let primary: ButtonLayout = .init(
        enabled: PrimaryNeutral.enabled,
        disabled: PrimaryNeutral.disabled
    )
}

extension ButtonLayout {
    
    // MARK: - Primary Style

    enum PrimaryNeutral {
        static let enabled: ButtonLayout.Properties = .init(
            titleFont: .themeFont(for: .body, weight: .semibold),
            titleColor: .white,
            backgroundColor: .blue
        )
        static let disabled: ButtonLayout.Properties = .init(
            titleFont: .themeFont(for: .body, weight: .semibold),
            titleColor: .mostLightestBlue,
            backgroundColor: .lighterBlue
        )
    }
}

