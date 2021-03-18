//
//  HomeViewController.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 23/12/20.
//

import UIKit

protocol HomeDisplayLogic: AnyObject {
    func displayUsefulToolsViewState(_ viewState: Home.UsefulTools.ViewState)
    func displayURL(_ url: URL)
}

final class HomeViewController: UIViewController {
    
    // MARK: - Dependencies
    
    private let interactor: HomeBusinessLogic
    private let router: HomeRoutingLogic
    
    // MARK: - View Components
    
    weak var contentView: HomeContentViewProtocol?
    
    // MARK: - Initializers
    
    init(
        interactor: HomeBusinessLogic,
        router: HomeRoutingLogic
    ) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        interactor.onViewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        view = HomeContentView(
            onTappedAddButtonClosure: { [weak self] in self?.router.routeToAddNewToolScene() },
            onTappedToolCellClosure: { [weak self] selectedRow in self?.interactor.handleToolSelection(at: selectedRow) },
            onTappedRemoveToolClosure: { [weak self] toolId in self?.onTappedRemoveToolAction(toolId) },
            onTappedErrorReloadButtonClosure: { [weak self] in self?.interactor.reloadTools() }
        )
        contentView = view as? HomeContentViewProtocol
    }
    
    // MARK: - Private Methods
    
    private func configureNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        title = L10n.Home.vuttr.uppercased()
        navigationController?.navigationBar.configure()
        configureSearchBar()
    }
    
    private func configureSearchBar() {
        let search = UISearchController(searchResultsController: nil)
        search.delegate = self
        let placeholderAppearance = UILabel.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        placeholderAppearance.font = .themeFont(for: .body, weight: .regular)
        let attributes = [NSAttributedString.Key.font : UIFont.themeFont(for: .body, weight: .regular)]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = attributes
        navigationItem.searchController = search
    }
    
    private func onTappedRemoveToolAction(_ toolId: UInt) {
        interactor.handleRemoveToolSelection(toolId)
        router.routeToRemoveToolScene()
    }
}

// MARK: - HomeDisplayLogic

extension HomeViewController: HomeDisplayLogic {
    
    func displayUsefulToolsViewState(_ viewState: Home.UsefulTools.ViewState) {
        contentView?.setupUsefulToolsState(viewState)
    }
    
    func displayURL(_ url: URL) {
        router.routeToURL(url)
    }
}

extension HomeViewController: UISearchControllerDelegate {}
