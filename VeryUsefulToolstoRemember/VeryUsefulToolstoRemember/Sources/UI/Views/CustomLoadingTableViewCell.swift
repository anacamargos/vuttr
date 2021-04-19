//
//  CustomLoadingTableViewCell.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 28/12/20.
//  Copyright © 2020 Ana Letícia Camargos. All rights reserved.
//

import UIKit

final class CustomLoadingTableViewCell: CodedTableViewCell {

    // MARK: - View Components

    private let loadingView: CustomLoadingView = CustomLoadingView()

    // MARK: - Override Methods

    override func addSubviews() {
        addSubview(loadingView)
    }

    override func constrainSubviews() {
        backgroundColor = .clear
        selectionStyle = .none
        loadingView.fillSuperview()
    }

    // MARK: - Public Methods

    func startLoading() {
        loadingView.startLoading()
    }
}
