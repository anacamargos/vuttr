//
//  TagCell.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 24/02/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import UIKit

final class TagCell: CodedCollectionViewCell {
    
    // MARK: - Constants
    
    private enum ViewMetrics {
        static let cornerRadius: CGFloat = 12
    }
    
    // MARK: - View Components
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .ink
        label.font = .themeFont(for: .body, weight: .regular)
        return label
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configureView()
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods
    
    override func addSubviews() {
        addSubview(titleLabel)
    }
    
    override func constrainSubviews() {
        constrainTitleLabel()
    }
    
    // MARK: - Private Methods
    
    private func configureView() {
        backgroundColor = .darkestWhite
        layer.cornerRadius = ViewMetrics.cornerRadius
    }
    
    private func constrainTitleLabel() {
        titleLabel.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            topConstant: Metrics.Spacing.tiny,
            leadingConstant: Metrics.Spacing.xSmall,
            bottomConstant: Metrics.Spacing.tiny,
            trailingConstant: Metrics.Spacing.xSmall
        )
    }
    
    // MARK: - Public Methods
    
    func setupTag(_ tagText: String) {
        titleLabel.text = tagText
    }
    
}
