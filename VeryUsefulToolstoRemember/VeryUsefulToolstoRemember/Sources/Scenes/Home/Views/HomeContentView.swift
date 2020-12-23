//
//  HomeContentView.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 23/12/20.
//

import UIKit

protocol HomeContentViewProtocol: AnyObject {}

final class HomeContentView: CodedView {
    
    // MARK: - View Components
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        return tableView
    }()
    
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
        addSubview(tableView)
    }
    
    override func constrainSubviews() {
        constrainTableView()
    }
    
    // MARK: - Private Methods
    
    private func constrainTableView() {
        tableView.fillSuperview()
    }
    
    private func configureView() {
        backgroundColor = .white
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
    }
}

// MARK: - HomeContentViewProtocol

extension HomeContentView: HomeContentViewProtocol {}
