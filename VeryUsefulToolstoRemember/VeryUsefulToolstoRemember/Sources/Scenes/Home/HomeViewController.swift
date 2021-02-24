//
//  HomeViewController.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 23/12/20.
//

import UIKit

protocol HomeDisplayLogic: AnyObject {
    func displayUsefulToolsViewState(_ viewState: Home.UsefulTools.ViewState)
}

final class HomeViewController: UIViewController {
    
    // MARK: - Dependencies
    
    private let router: HomeRoutingLogic
    
    // MARK: - View Components
    
    weak var contentView: HomeContentViewProtocol?
    
    // MARK: - Initializers
    
    init(
        router: HomeRoutingLogic
    ) {
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            let tool = Home.UsefulTools.Tool(
                title: "Notion",
                description: "All in one tool to organize teams and ideas. Write, plan, collaborate, and get organized",
                tags: [
                    .init(text: "#test", estimatedWidth: self.getEstimatedWidthByWord("#test")),
                    .init(text: "#test", estimatedWidth: self.getEstimatedWidthByWord("#test")),
                    .init(text: "#testawdqwd", estimatedWidth: self.getEstimatedWidthByWord("#testawdqwd")),
                    .init(text: "#test", estimatedWidth: self.getEstimatedWidthByWord("#test")),
                    .init(text: "#test", estimatedWidth: self.getEstimatedWidthByWord("#test")),
                    .init(text: "#testawdqwd", estimatedWidth: self.getEstimatedWidthByWord("#testawdqwd")),
                ]
            )
            let viewData = Home.UsefulTools.ViewData(tools: [tool, tool, tool])
            self.displayUsefulToolsViewState(.content(viewData))
        }
    }
    
    override func loadView() {
        super.loadView()
        view = HomeContentView(onTappedAddButtonClosure: { [weak self] in self?.router.routeToAddNewToolScene() })
        contentView = view as? HomeContentViewProtocol
    }
    
    private func getEstimatedWidthByWord(_ word: String) -> CGFloat {
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Metrics.FontSize.body.value)]
        let estimatedWidth = NSString(string: word).boundingRect(with: .zero, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return estimatedWidth.width
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

// MARK: - HomeDisplayLogic

extension HomeViewController: HomeDisplayLogic {
    
    func displayUsefulToolsViewState(_ viewState: Home.UsefulTools.ViewState) {
        contentView?.setupUsefulToolsState(viewState)
    }
}

extension HomeViewController: UISearchControllerDelegate {}
