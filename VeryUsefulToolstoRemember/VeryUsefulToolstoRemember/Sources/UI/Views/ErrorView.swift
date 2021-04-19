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
        static let errorImageViewSize: CGFloat = 50
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
        button.imageView?.contentMode = .scaleAspectFit
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
        reloadButton.anchor(
            top: topAnchor,
            topConstant: Metrics.Spacing.xLarge,
            widthConstant: ViewMetrics.errorImageViewSize,
            heightConstant: ViewMetrics.errorImageViewSize
        )
        reloadButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    private func constrainReloadButton() {
        errorLabel.anchor(
            top: reloadButton.bottomAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            topConstant: Metrics.Spacing.small,
            leadingConstant: Metrics.Spacing.small,
            bottomConstant: Metrics.Spacing.xLarge,
            trailingConstant: Metrics.Spacing.small
        )
    }
}
