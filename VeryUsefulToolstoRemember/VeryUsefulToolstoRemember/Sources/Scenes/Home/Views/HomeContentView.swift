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
    
    // MARK: - Constants
    
    private enum ViewMetrics {
        static let addViewSize: CGFloat = 56
        static let iconSmallSize: CGFloat = 20
        static let shadowAlpha: Float = 0.05
        static let shadowY: CGFloat = 5
        static let shadowBlur: CGFloat = 7
    }
    
    // MARK: - Dependencies
    
    private let onTappedAddButtonClosure: () -> Void
    private let onTappedToolCellClosure: (Int) -> Void
    private let onTappedRemoveToolClosure: (UInt) -> Void
    private let onTappedErrorReloadButtonClosure: () -> Void
    
    // MARK: - Properties
    
    private var viewState: Home.UsefulTools.ViewState = .loading
    
    // MARK: - View Components
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.contentInset = .init(top: .zero, left: .zero, bottom: Metrics.Spacing.medium, right: .zero)
        return tableView
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.applyShadow(color: .black, alpha: ViewMetrics.shadowAlpha, x: .zero, y: ViewMetrics.shadowY, blur: ViewMetrics.shadowBlur, spread: .zero)
        return button
    }()
    
    private let addImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .addIcon
        return imageView
    }()
    
    // MARK: - Initializers
    
    init(
        frame: CGRect = .zero,
        onTappedAddButtonClosure: @escaping () -> Void,
        onTappedToolCellClosure: @escaping (Int) -> Void,
        onTappedRemoveToolClosure: @escaping (UInt) -> Void,
        onTappedErrorReloadButtonClosure: @escaping () -> Void
    ) {
        self.onTappedAddButtonClosure = onTappedAddButtonClosure
        self.onTappedToolCellClosure = onTappedToolCellClosure
        self.onTappedRemoveToolClosure = onTappedRemoveToolClosure
        self.onTappedErrorReloadButtonClosure = onTappedErrorReloadButtonClosure
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
        addSubview(addButton)
        addButton.addSubview(addImage)
    }
    
    override func constrainSubviews() {
        constrainTableView()
        constrainAddButton()
        constrainAddImage()
    }
    
    // MARK: - Private Methods
    
    private func constrainTableView() {
        tableView.fillSuperview()
    }
    
    private func constrainAddButton() {
        addButton.anchor(
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            bottomConstant: Metrics.Spacing.base,
            trailingConstant: Metrics.Spacing.base,
            widthConstant: ViewMetrics.addViewSize,
            heightConstant: ViewMetrics.addViewSize
        )
        addButton.layer.cornerRadius = 0.5 * ViewMetrics.addViewSize
    }
    
    private func constrainAddImage() {
        addImage.anchor(
            widthConstant: ViewMetrics.iconSmallSize,
            heightConstant: ViewMetrics.iconSmallSize
        )
        addImage.centerXAnchor.constraint(equalTo: addButton.centerXAnchor).isActive = true
        addImage.centerYAnchor.constraint(equalTo: addButton.centerYAnchor).isActive = true
    }
    
    private func configureView() {
        backgroundColor = .white
        addButton.addTarget(self, action: #selector(onTappedAddButton), for: .touchUpInside)
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UsefulToolCell.self, forCellReuseIdentifier: UsefulToolCell.className)
        tableView.register(CustomLoadingTableViewCell.self, forCellReuseIdentifier: CustomLoadingTableViewCell.className)
        tableView.register(EmptyTableViewCell.self, forCellReuseIdentifier: EmptyTableViewCell.className)
        tableView.register(ErrorTableViewCell.self, forCellReuseIdentifier: ErrorTableViewCell.className)
    }
    
    private func getLoadingCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomLoadingTableViewCell = tableView.reusableCell(for: CustomLoadingTableViewCell.className, for: indexPath)
        cell.startLoading()
        return cell
    }
    
    private func getEmptyCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell: EmptyTableViewCell = tableView.reusableCell(for: EmptyTableViewCell.className, for: indexPath)
        cell.setupLabelText(L10n.Home.noRegisteredTools)
        return cell
    }
    
    private func getErrorCell(for indexPath: IndexPath) -> UITableViewCell {
        let cell: ErrorTableViewCell = tableView.reusableCell(for: ErrorTableViewCell.className, for: indexPath)
        return cell
    }
    
    @objc private func onTappedAddButton() {
        onTappedAddButtonClosure()
    }
}

// MARK: - HomeContentViewProtocol

extension HomeContentView: HomeContentViewProtocol {
    
    func setupUsefulToolsState(_ viewState: Home.UsefulTools.ViewState) {
        self.viewState = viewState
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource

extension HomeContentView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewState {
        case .loading, .error, .empty:
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
            cell.onTappedRemoveToolButtonClosure = onTappedRemoveToolClosure
            return cell
        case .loading:
            return getLoadingCell(for: indexPath)
        case .empty:
            return getEmptyCell(for: indexPath)
        case .error:
            return getErrorCell(for: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if case .content = viewState {
            onTappedToolCellClosure(indexPath.row)
        } else if case .error = viewState {
            onTappedErrorReloadButtonClosure()
        }
    }
}
