//
//  HomeContentView.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 23/12/20.
//

import UIKit

protocol HomeContentViewProtocol: AnyObject {}

final class HomeContentView: CodedView {
    
    // MARK: - Initializers
    
    override init(
        frame: CGRect = .zero
    ) {
        super.init(frame: frame)
        configureView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods
    
    override func addSubviews() {
    }
    
    override func constrainSubviews() {
    }
    
    // MARK: - Private Methods
    
    private func configureView() {
        backgroundColor = .white
    }
}

// MARK: - HomeContentViewProtocol

extension HomeContentView: HomeContentViewProtocol {}
