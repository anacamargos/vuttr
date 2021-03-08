//
//  RemoveToolContentView.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 08/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import UIKit

protocol RemoveToolContentViewProtocol: AnyObject {}

final class RemoveToolContentView: CodedView {
    
    // MARK: - Initializers
    
    override init(
        frame: CGRect = .zero
    ) {
        super.init(frame: frame)
        configureView()
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func configureView() {
        backgroundColor = .secundary80
    }
}

// MARK: - RemoveToolContentViewProtocol

extension RemoveToolContentView: RemoveToolContentViewProtocol {}
