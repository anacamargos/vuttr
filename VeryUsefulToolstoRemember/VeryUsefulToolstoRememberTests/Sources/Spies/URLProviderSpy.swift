//
//  URLProviderSpy.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 07/04/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation
@testable import VeryUsefulToolstoRemember

final class URLProviderSpy: URLProvider {
    
    private(set) var getBaseURLPassedServiceGroups = [ServiceGroup]()
    
    func getBaseURL(forServiceGroup group: ServiceGroup) -> String {
        getBaseURLPassedServiceGroups.append(group)
        return "www.test.com"
    }
}
