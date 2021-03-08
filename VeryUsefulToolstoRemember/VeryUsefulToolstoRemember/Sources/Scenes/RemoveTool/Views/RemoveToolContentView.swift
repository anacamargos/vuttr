//
//  RemoveToolContentView.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 08/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import UIKit

protocol RemoveToolContentViewProtocol: AnyObject {}

final class RemoveToolContentView: CodedView {
    
    // MARK: - Constants
    
    private enum ViewMetrics {
        static let cornerRadius: CGFloat = 4.0
        static let closeButtonSize: CGFloat = 16.0
    }
    
    // MARK: - View Components
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .ink
        label.text = L10n.AddNewTool.removeToolTitle
        label.font = .themeFont(for: .subtitle, weight: .semibold)
        label.numberOfLines = .zero
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(.close, for: .normal)
        return button
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .ink
        label.font = .themeFont(for: .body, weight: .regular)
        label.numberOfLines = .zero
        return label
    }()
    
    private let cancelButton: LayoutableButton = {
        let button = LayoutableButton(layout: .secundary)
        button.setTitle(L10n.AddNewTool.removeToolCancel, for: .normal)
        button.contentEdgeInsets = .init(top: Metrics.Spacing.small, left: Metrics.Spacing.base, bottom: Metrics.Spacing.small, right: Metrics.Spacing.base)
        return button
    }()
    
    private let removeToolButton: LayoutableButton = {
        let button = LayoutableButton(layout: .primary)
        button.setTitle(L10n.AddNewTool.removeToolConfirmation, for: .normal)
        button.contentEdgeInsets = .init(top: Metrics.Spacing.small, left: Metrics.Spacing.base, bottom: Metrics.Spacing.small, right: Metrics.Spacing.base)
        return button
    }()
    
    private let container: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = ViewMetrics.cornerRadius
        return view
    }()
    
    // MARK: - Initializers
    
    override init(
        frame: CGRect = .zero
    ) {
        super.init(frame: frame)
        configureView()
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods
    
    override func addSubviews() {
        addSubview(container)
        container.addSubview(titleLabel)
        container.addSubview(closeButton)
        container.addSubview(descriptionLabel)
        container.addSubview(cancelButton)
        container.addSubview(removeToolButton)
    }
    
    override func constrainSubviews() {
        constrainContainer()
        constrainTitleLabel()
        constrainCloseButton()
        constrainDescriptionLabel()
        constrainCancelButton()
        constrainRemoveToolButton()
    }
    
    // MARK: - Private Methods
    
    private func constrainContainer() {
        container.anchor(
            leading: leadingAnchor,
            trailing: trailingAnchor,
            leadingConstant: Metrics.Spacing.small,
            trailingConstant: Metrics.Spacing.small
        )
        container.anchorCenterYToSuperview()
    }
    
    private func constrainTitleLabel() {
        titleLabel.anchor(
            top: container.topAnchor,
            leading: container.leadingAnchor,
            trailing: closeButton.leadingAnchor,
            topConstant: Metrics.Spacing.small,
            leadingConstant: Metrics.Spacing.small,
            trailingConstant: Metrics.Spacing.small
        )
    }
    
    private func constrainCloseButton() {
        closeButton.anchor(
            top: container.topAnchor,
            trailing: container.trailingAnchor,
            topConstant: Metrics.Spacing.small,
            trailingConstant: Metrics.Spacing.small,
            widthConstant: ViewMetrics.closeButtonSize,
            heightConstant: ViewMetrics.closeButtonSize
        )
    }
    
    private func constrainDescriptionLabel() {
        descriptionLabel.anchor(
            top: titleLabel.bottomAnchor,
            leading: titleLabel.leadingAnchor,
            trailing: container.trailingAnchor,
            topConstant: Metrics.Spacing.small,
            trailingConstant: Metrics.Spacing.small
        )
    }
    
    private func constrainRemoveToolButton() {
        removeToolButton.anchor(
            top: descriptionLabel.bottomAnchor,
            bottom: container.bottomAnchor,
            trailing: container.trailingAnchor,
            topConstant: Metrics.Spacing.base,
            bottomConstant: Metrics.Spacing.small,
            trailingConstant: Metrics.Spacing.small
        )
    }
    
    private func constrainCancelButton() {
        cancelButton.anchor(
            top: removeToolButton.topAnchor,
            bottom: removeToolButton.bottomAnchor,
            trailing: removeToolButton.leadingAnchor,
            trailingConstant: Metrics.Spacing.xSmall
        )
    }
    
    private func configureView() {
        backgroundColor = .secundary80
    }
    
    // MARK: - Public Methods
    
    func setupViewData(_ toolName: String) {
        descriptionLabel.text = L10n.AddNewTool.removeToolDescription(toolName)
    }
}

// MARK: - RemoveToolContentViewProtocol

extension RemoveToolContentView: RemoveToolContentViewProtocol {}
