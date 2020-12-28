//
//  HomeViewController.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 23/12/20.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - View Components
    
    weak var contentView: HomeContentViewProtocol?
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    
    override func loadView() {
        super.loadView()
        view = HomeContentView()
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
}

extension HomeViewController: UISearchControllerDelegate {}
