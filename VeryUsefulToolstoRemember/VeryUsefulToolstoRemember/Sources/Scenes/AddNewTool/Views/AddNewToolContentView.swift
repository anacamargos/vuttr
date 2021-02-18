//
//  AddNewToolContentView.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 18/02/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import UIKit

final class AddNewToolContentView: CodedView {
    
    // MARK: - Constants
    
    private enum ViewMetrics {
        static let cornerRadius: CGFloat = 4.0
    }
    
    // MARK: - Dependencies
    
    private let onTappedCloseButtonClosure: () -> Void
    
    // MARK: - View Components
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .ink
        label.text = L10n.AddNewTool.addNewToolTitle
        label.font = .themeFont(for: .subtitle, weight: .semibold)
        label.numberOfLines = .zero
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(.close, for: .normal)
        return button
    }()
    
    private let container: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = ViewMetrics.cornerRadius
        return view
    }()
    
    // MARK: - Initializers
    
    init(
        frame: CGRect = .zero,
        onTappedCloseButtonClosure: @escaping () -> Void
    ) {
        self.onTappedCloseButtonClosure = onTappedCloseButtonClosure
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
    }
    
    override func constrainSubviews() {
        constrainContainer()
        constrainTitleLabel()
        constrainCloseButton()
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
            leadingConstant: Metrics.Spacing.small,
            trailingConstant: Metrics.Spacing.small
        )
    }
    
    private func constrainCloseButton() {
        closeButton.anchor(
            top: container.topAnchor,
            trailing: container.trailingAnchor,
            trailingConstant: Metrics.Spacing.small
        )
    }
    
    private func configureView() {
        backgroundColor = .secundary80
        closeButton.addTarget(self, action: #selector(onTappedCloseButton), for: .touchUpInside)
    }
    
    @objc private func onTappedCloseButton() {
        onTappedCloseButtonClosure()
    }
}
