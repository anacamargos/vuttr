//
//  CustomLoadingView.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 28/12/20.
//  Copyright © 2020 Ana Letícia Camargos. All rights reserved.
//

import UIKit

final class CustomLoadingView: CodedView {
    
    // MARK: - View Components
    
    private let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .gray)
        return view
    }()
    
    deinit {
        activityIndicator.stopAnimating()
    }
    
    // MARK: - Override Methods
    
    override func addSubviews() {
        addSubview(activityIndicator)
    }
    
    override func constrainSubviews() {
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.anchor(
            top: topAnchor,
            bottom: bottomAnchor,
            topConstant: Metrics.Spacing.xSmall,
            bottomConstant: Metrics.Spacing.xSmall
        )
    }
    
    // MARK: - Public Methods
    
    func startLoading() {
        activityIndicator.startAnimating()
    }
}
