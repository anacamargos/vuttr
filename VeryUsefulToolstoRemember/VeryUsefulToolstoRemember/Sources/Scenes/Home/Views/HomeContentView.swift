//
//  HomeContentView.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 23/12/20.
//

import UIKit

protocol HomeContentViewProtocol: AnyObject {
    func setupUsefulToolsState(_ viewState: Home.UsefulTools.ViewState)
}

final class HomeContentView: CodedView {
    
    // MARK: - Properties
    
    private var viewState: Home.UsefulTools.ViewState = .loading
    
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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UsefulToolCell.self, forCellReuseIdentifier: UsefulToolCell.className)
        tableView.register(CustomLoadingTableViewCell.self, forCellReuseIdentifier: CustomLoadingTableViewCell.className)
    }
    
    private func getLoadingCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomLoadingTableViewCell = tableView.reusableCell(for: CustomLoadingTableViewCell.className, for: indexPath)
        cell.startLoading()
        return cell
    }
}

// MARK: - HomeContentViewProtocol

extension HomeContentView: HomeContentViewProtocol {
    
    func setupUsefulToolsState(_ viewState: Home.UsefulTools.ViewState) {
        self.viewState = viewState
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource

extension HomeContentView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewState {
        case .loading, .error:
            return 1
        case let .content(viewData):
            return viewData.tools.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewState {
        case let .content(viewData):
            let cell: UsefulToolCell = tableView.reusableCell(for: UsefulToolCell.className, for: indexPath)
            let currentTool = viewData.tools[indexPath.row]
            cell.setupViewData(currentTool)
            return cell
        case .loading:
            return getLoadingCell(for: indexPath)
        case .error:
            return .init()
        }
    }
}
