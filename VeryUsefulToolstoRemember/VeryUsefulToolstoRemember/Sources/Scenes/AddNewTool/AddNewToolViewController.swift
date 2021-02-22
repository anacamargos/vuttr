//
//  AddNewToolViewController.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 18/02/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import UIKit

final class AddNewToolViewController: UIViewController {
    
    // MARK: - View Controller Lifecycle
    
    override func loadView() {
        super.loadView()
        view = AddNewToolContentView(onTappedCloseButtonClosure: {}, onTappedAddToolButtonClosure: { _ in })
    }
}
