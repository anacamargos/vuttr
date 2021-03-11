//
//  HomeInteractorDummy.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 25/02/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation
@testable import VeryUsefulToolstoRemember

final class HomeInteractorDummy: HomeBusinessLogic {
    func onViewDidLoad() {}
    func handleToolSelection(at row: Int) {}
    func handleRemoveToolSelection(_ toolId: UInt) {}
}
