//
//  RemoveToolViewController.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 08/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import UIKit

final class RemoveToolViewController: UIViewController {
    
    // MARK: - View Components
    
    weak var contentView: RemoveToolContentViewProtocol?
    
    // MARK: - Initializers
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Lifecycle
    
    override func loadView() {
        super.loadView()
        view = RemoveToolContentView()
        contentView = view as? RemoveToolContentViewProtocol
    }
    
}
