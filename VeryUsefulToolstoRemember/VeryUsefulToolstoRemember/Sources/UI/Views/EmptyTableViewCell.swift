//
//  EmptyTableViewCell.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 16/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import UIKit

final class EmptyTableViewCell: CodedTableViewCell {
    
    // MARK: - View Components
    
    private let emptyView: EmptyView = EmptyView()
    
    // MARK: - Override Methods
    
    override func addSubviews() {
        addSubview(emptyView)
    }
    
    override func constrainSubviews() {
        backgroundColor = .clear
        selectionStyle = .none
        emptyView.fillSuperview()
    }
    
    // MARK: - Public Methods
    
    func setupLabelText(_ text: String) {
        emptyView.setupLabelText(text)
    }
}
