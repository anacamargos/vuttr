//
//  HTTPClientDummy.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 12/04/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation
@testable import VeryUsefulToolstoRemember

final class HTTPClientDummy: HTTPClient { //
    func get(from networkRequest: NetworkRequest, then handle: @escaping (Result<NetworkResponse, NetworkError>) -> Void) {}
}
