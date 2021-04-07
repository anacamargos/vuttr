//
//  URLProviderDummy.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 07/04/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation
@testable import VeryUsefulToolstoRemember

final class URLProviderDummy: URLProvider {
    func getBaseURL(forServiceGroup group: ServiceGroup) -> String { return "" }
}
