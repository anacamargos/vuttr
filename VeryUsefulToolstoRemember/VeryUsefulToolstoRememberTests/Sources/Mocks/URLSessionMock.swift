//
//  URLSessionMock.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 12/04/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation
@testable import VeryUsefulToolstoRemember

final class URLSessionMock: URLSessionProvider {

    // swiftlint:disable:next large_tuple
    var dataTaskResultToBeReturned: (data: Data?, response: URLResponse?, error: Error?) = (nil, nil, nil)
    private(set) var dataTaskPassedRequests = [URLRequest]()

    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        dataTaskPassedRequests.append(request)
        completionHandler(dataTaskResultToBeReturned.data, dataTaskResultToBeReturned.response, dataTaskResultToBeReturned.error)
        return URLSession.shared.dataTask(with: request)
    }
}
