//
//  HomePresenterDummy.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 02/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation
@testable import VeryUsefulToolstoRemember

final class HomePresenterDummy: HomePresentationLogic {
    func presentToolsResponse(_ response: Home.UsefulTools.Response) {}
    func presentURL(_ url: URL) {}
    func presentAddNewToolSuccessMessage() {}
    func presentRemoveToolSuccessMessage() {}
}
