//
//  HomeViewController.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 23/12/20.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let searchFieldKey: String = "searchField"
    }
    
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
    
    private func configureNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        title = L10n.Home.vuttr.uppercased()
        navigationController?.navigationBar.configure()
        
        let search = UISearchController(searchResultsController: nil)
        if let textfield = search.searchBar.value(forKey: Constants.searchFieldKey) as? UITextField {
            textfield.placeholder = L10n.Home.search
        }
        navigationItem.searchController = search
    }
}
