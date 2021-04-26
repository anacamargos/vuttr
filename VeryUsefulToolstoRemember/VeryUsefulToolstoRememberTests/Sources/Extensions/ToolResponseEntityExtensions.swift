//
//  ToolResponseEntityExtensions.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 16/04/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation
@testable import VeryUsefulToolstoRemember

extension ToolResponseEntity {
    static var mock: ToolResponseEntity {
        .init(id: 0, title: "Notion", link: "https://notion.so", description: "All in one tool to organize teams and ideas. Write, plan, collaborate, and get organized.", tags: ["organization", "planning", "collaboration", "writing"])
    }
}
