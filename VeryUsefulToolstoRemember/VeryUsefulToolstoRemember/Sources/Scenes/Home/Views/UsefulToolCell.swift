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
    }
    
    override func constrainSubviews() {
        constrainContainerView()
        constrainTitleLabel()
        constrainDescriptionLabel()
    }
    
    // MARK: - Private Methods
    
    private func constrainContainerView() {
        containerView.anchor(
            top: contentView.topAnchor,
            left: contentView.leftAnchor,
            bottom: contentView.bottomAnchor,
            right: contentView.rightAnchor,
            topConstant: Metrics.Spacing.small,
            leftConstant: Metrics.Spacing.small,
            rightConstant: Metrics.Spacing.small
        )
    }
    
    private func constrainTitleLabel() {
        titleLabel.anchor(
            top: containerView.topAnchor,
            left: containerView.leftAnchor,
            right: containerView.rightAnchor,
            topConstant: Metrics.Spacing.small,
            leftConstant: Metrics.Spacing.small,
            rightConstant: Metrics.Spacing.small
        )
    }
    
    private func constrainDescriptionLabel() {
        descriptionLabel.anchor(
            top: titleLabel.bottomAnchor,
            left: titleLabel.leftAnchor,
            bottom: containerView.bottomAnchor,
            right: titleLabel.rightAnchor,
            topConstant: Metrics.Spacing.tiny,
            bottomConstant: Metrics.Spacing.small
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
