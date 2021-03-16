//
//  EmptyView.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 15/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import UIKit

final class EmptyView: CodedView {
    
    // MARK: - View Components
    
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.font = .themeFont(for: .body, weight: .semibold)
        label.textColor = .ink
        label.numberOfLines = .zero
        label.textAlignment = .center
        label.text = L10n.Home.noRegisteredTools
        return label
    }()
    
    // MARK: - Override Methods
    
    override func addSubviews() {
        addSubview(emptyLabel)
    }
    
    override func constrainSubviews() {
        emptyLabel.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            topConstant: Metrics.Spacing.xLarge,
            leadingConstant: Metrics.Spacing.small,
            bottomConstant: Metrics.Spacing.xLarge,
            trailingConstant: Metrics.Spacing.small
        )
    }
    
    // MARK: - Public Methods
    
    func setupLabelText(_ text: String) {
        emptyLabel.text = text
    }
}
