//
//  UsefulToolCell.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 28/12/20.
//  Copyright © 2020 Ana Letícia Camargos. All rights reserved.
//

import UIKit

final class UsefulToolCell: CodedTableViewCell {
    
    // MARK: - View Components
    
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
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
    }
    
    override func constrainSubviews() {
        constrainTitleLabel()
        constrainDescriptionLabel()
    }
    
    // MARK: - Private Methods
    
    private func constrainTitleLabel() {
        titleLabel.anchor(
            top: contentView.topAnchor,
            left: contentView.leftAnchor,
            right: contentView.rightAnchor,
            topConstant: Metrics.Spacing.small,
            leftConstant: Metrics.Spacing.small,
            rightConstant: Metrics.Spacing.small
        )
    }
    
    private func constrainDescriptionLabel() {
        descriptionLabel.anchor(
            top: titleLabel.bottomAnchor,
            left: titleLabel.leftAnchor,
            bottom: contentView.bottomAnchor,
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
}
