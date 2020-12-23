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
    
    override func loadView() {
        super.loadView()
        view = HomeContentView()
        contentView = view as? HomeContentViewProtocol
    }
}
