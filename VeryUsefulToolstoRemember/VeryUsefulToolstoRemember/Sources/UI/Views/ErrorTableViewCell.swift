//
//  ErrorTableViewCell.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 18/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import UIKit

final class ErrorTableViewCell: CodedTableViewCell {
    
    // MARK: - View Components
    
    private let errorView: ErrorView = ErrorView()
    
    // MARK: - Override Methods
    
    override func addSubviews() {
        addSubview(errorView)
    }
    
    override func constrainSubviews() {
        backgroundColor = .clear
        selectionStyle = .none
        errorView.fillSuperview()
    }
}
