//
//  TagCell.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 24/02/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import UIKit

final class TagCell: CodedCollectionViewCell {
    
    // MARK: - View Components
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .ink
        label.font = .themeFont(for: .body, weight: .regular)
        return label
    }()
    
    // MARK: - Override Methods
    
    override func addSubviews() {
        addSubview(titleLabel)
    }
    
    override func constrainSubviews() {
        constrainTitleLabel()
    }
    
    // MARK: - Private Methods
    
    private func constrainTitleLabel() {
        titleLabel.fillSuperview()
    }
    
    // MARK: - Public Methods
    
    func setupTag(_ tagText: String) {
        titleLabel.text = tagText
    }
    
}
