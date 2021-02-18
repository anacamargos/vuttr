//
//  UsefulToolCell.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 28/12/20.
//  Copyright © 2020 Ana Letícia Camargos. All rights reserved.
//

import UIKit

final class UsefulToolCell: CodedTableViewCell {
    
    // MARK: - View Metris
    
    private enum ViewMetrics {
        static let cornerRadius: CGFloat = 5
        static let borderWidth: CGFloat = 1
        static let shadowAlpha: Float = 0.05
        static let shadowY: CGFloat = 5
        static let shadowBlur: CGFloat = 7
        static let iconSmallestSize: CGFloat = 12
    }
    
    // MARK: - View Components
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = ViewMetrics.cornerRadius
        view.layer.borderWidth = ViewMetrics.borderWidth
        view.layer.borderColor = UIColor.darkestWhite.cgColor
        view.backgroundColor = .white
        view.applyShadow(color: .black, alpha: ViewMetrics.shadowAlpha, x: .zero, y: ViewMetrics.shadowY, blur: ViewMetrics.shadowBlur, spread: .zero)
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .themeFont(for: .subtitle, weight: .semibold)
        label.textColor = .ink
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .themeFont(for: .body, weight: .regular)
        label.textColor = .ink
        label.numberOfLines = .zero
        return label
    }()
    
    private let closeIcon: UIButton = {
        let button = UIButton()
        button.setImage(.close, for: .normal)
        return button
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods
    
    override func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(closeIcon)
    }
    
    override func constrainSubviews() {
        constrainContainerView()
        constrainTitleLabel()
        constrainDescriptionLabel()
        constrainCloseIcon()
    }
    
    // MARK: - Private Methods
    
    private func constrainContainerView() {
        containerView.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor,
            topConstant: Metrics.Spacing.small,
            leadingConstant: Metrics.Spacing.small,
            trailingConstant: Metrics.Spacing.small
        )
    }
    
    private func constrainCloseIcon() {
        closeIcon.anchor(
            top: containerView.topAnchor,
            trailing: containerView.trailingAnchor,
            topConstant: Metrics.Spacing.small,
            trailingConstant: Metrics.Spacing.small,
            widthConstant: ViewMetrics.iconSmallestSize,
            heightConstant: ViewMetrics.iconSmallestSize
        )
    }
    
    private func constrainTitleLabel() {
        titleLabel.anchor(
            top: containerView.topAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            topConstant: Metrics.Spacing.small,
            leadingConstant: Metrics.Spacing.small,
            trailingConstant: Metrics.Spacing.small + ViewMetrics.iconSmallestSize + Metrics.Spacing.tiny
        )
    }
    
    private func constrainDescriptionLabel() {
        descriptionLabel.anchor(
            top: titleLabel.bottomAnchor,
            leading: titleLabel.leadingAnchor,
            bottom: containerView.bottomAnchor,
            trailing: containerView.trailingAnchor,
            topConstant: Metrics.Spacing.tiny,
            bottomConstant: Metrics.Spacing.small,
            trailingConstant: Metrics.Spacing.small
        )
    }
    
    private func configureView() {
        backgroundColor = .clear
        selectionStyle = .none
        contentView.isUserInteractionEnabled = true
    }
    
    // MARK: - Public Methods
    
    func setupViewData(_ viewData: Home.UsefulTools.Tool) {
        titleLabel.text = viewData.title
        descriptionLabel.text = viewData.description
    }
}
