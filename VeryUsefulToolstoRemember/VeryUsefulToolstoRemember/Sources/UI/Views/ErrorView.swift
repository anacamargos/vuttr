//
//  ErrorView.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 17/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import UIKit

final class ErrorView: CodedView {
    
    // MARK: - View Metrics
    
    private enum ViewMetrics {
        static let errorImageViewSize: CGFloat = 35
    }
    
    // MARK: - View Components
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.font = .themeFont(for: .body, weight: .semibold)
        label.textColor = .ink
        label.numberOfLines = .zero
        label.textAlignment = .center
        label.text = L10n.Home.errorMessage
        return label
    }()
    
    private let reloadButton: UIButton = {
        let button = UIButton()
        button.setImage(.reloadArrow, for: .normal)
        return button
    }()
    
    // MARK: - Override Methods
    
    override func addSubviews() {
        addSubview(errorLabel)
        addSubview(reloadButton)
    }
    
    override func constrainSubviews() {
        constrainErrorLabel()
        constrainReloadButton()
    }
    
    // MARK: - Private Methods
    
    private func constrainErrorLabel() {
        errorLabel.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            topConstant: Metrics.Spacing.xLarge,
            leadingConstant: Metrics.Spacing.small,
            trailingConstant: Metrics.Spacing.small
        )
    }
    
    private func constrainReloadButton() {
        reloadButton.anchor(
            top: errorLabel.bottomAnchor,
            topConstant: Metrics.Spacing.small,
            widthConstant: ViewMetrics.errorImageViewSize,
            heightConstant: ViewMetrics.errorImageViewSize
        )
    }
}
