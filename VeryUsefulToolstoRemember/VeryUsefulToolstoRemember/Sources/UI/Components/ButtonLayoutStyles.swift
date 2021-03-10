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
    
    static let secundary: ButtonLayout = .init(
        enabled: SecondaryNeutral.enabled,
        disabled: SecondaryNeutral.disabled
    )
    
    static let primaryDanger: ButtonLayout = .init(
        enabled: PrimaryDanger.enabled,
        disabled: PrimaryDanger.disabled
    )
    
    static let secundaryDanger: ButtonLayout = .init(
        enabled: SecondaryDanger.enabled,
        disabled: SecondaryDanger.disabled
    )
}

extension ButtonLayout {
    
    // MARK: - Primary Style

    enum PrimaryNeutral {
        static let enabled: ButtonLayout.Properties = .init(
            titleFont: .themeFont(for: .body, weight: .semibold),
            titleColor: .white,
            backgroundColor: .blue,
            selectedBackgroundColor: .darkerBlue
        )
        static let disabled: ButtonLayout.Properties = .init(
            titleFont: .themeFont(for: .body, weight: .semibold),
            titleColor: .mostLightestBlue,
            backgroundColor: .lighterBlue
        )
    }
    
    enum SecondaryNeutral {
        static let enabled: ButtonLayout.Properties = .init(
            titleFont: .themeFont(for: .body, weight: .semibold),
            titleColor: .blue,
            backgroundColor: .mostLightestBlue,
            selectedBackgroundColor: .lighterBlue
        )
        static let disabled: ButtonLayout.Properties = .init(
            titleFont: .themeFont(for: .body, weight: .semibold),
            titleColor: .lighterBlue,
            backgroundColor: .mostLightestBlue
        )
    }
    
    enum PrimaryDanger {
        static let enabled: ButtonLayout.Properties = .init(
            titleFont: .themeFont(for: .body, weight: .semibold),
            titleColor: .white,
            backgroundColor: .red,
            selectedBackgroundColor: .darkerRed
        )
        static let disabled: ButtonLayout.Properties = .init(
            titleFont: .themeFont(for: .body, weight: .semibold),
            titleColor: .mostLightestRed,
            backgroundColor: .lightRed
        )
    }
    
    enum SecondaryDanger {
        static let enabled: ButtonLayout.Properties = .init(
            titleFont: .themeFont(for: .body, weight: .semibold),
            titleColor: .red,
            backgroundColor: .mostLightestRed,
            selectedBackgroundColor: .lighterRed
        )
        static let disabled: ButtonLayout.Properties = .init(
            titleFont: .themeFont(for: .body, weight: .semibold),
            titleColor: .lightRed,
            backgroundColor: .mostLightestRed
        )
    }
}

