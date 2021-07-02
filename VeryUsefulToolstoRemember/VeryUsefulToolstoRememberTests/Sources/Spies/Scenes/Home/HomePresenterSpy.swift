//
//  HomePresenterSpy.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 02/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation
@testable import VeryUsefulToolstoRemember

final class HomePresenterSpy: HomePresentationLogic {

    private(set) var presentToolsResponsePassedResponses = [Home.UsefulTools.Response]()

    func presentToolsResponse(_ response: Home.UsefulTools.Response) {
        presentToolsResponsePassedResponses.append(response)
    }

    private(set) var presentURLPassedURLs = [URL]()

    func presentURL(_ url: URL) {
        presentURLPassedURLs.append(url)
    }

    private(set) var presentAddNewToolSuccessMessageCalled = false

    func presentAddNewToolSuccessMessage() {
        presentAddNewToolSuccessMessageCalled = true
    }

    private(set) var presentRemoveToolSuccessMessageCalled = false

    func presentRemoveToolSuccessMessage() {
        presentRemoveToolSuccessMessageCalled = true
    }
}
