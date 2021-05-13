//
//  AddNewToolPresenterSpy.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 13/05/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation
@testable import VeryUsefulToolstoRemember

final class AddNewToolPresenterSpy: AddNewToolPresentationLogic {

    private(set) var presentToolsResponsePassedResponses = [AddNewTool.Response]()

    func presentToolsResponse(_ response: AddNewTool.Response) {
        presentToolsResponsePassedResponses.append(response)
    }
}
