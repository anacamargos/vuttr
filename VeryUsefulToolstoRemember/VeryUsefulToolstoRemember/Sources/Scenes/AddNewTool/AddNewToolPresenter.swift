//
//  AddNewToolPresenter.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 05/05/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation

protocol AddNewToolPresentationLogic {}

final class AddNewToolPresenter {
    
    // MARK: - Dependencies

    weak var viewController: AddNewToolDisplayLogic?
}

// MARK: - AddNewToolPresentationLogic

extension AddNewToolPresenter: AddNewToolPresentationLogic {}
