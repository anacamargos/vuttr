//
//  GetUsefulToolsUseCaseModelsExtensions.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 01/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation
@testable import VeryUsefulToolstoRemember

extension GetUsefulToolsUseCaseModels.Tool {
    static var mock: GetUsefulToolsUseCaseModels.Tool {
        .init(
            id: .zero,
            title: "Notion",
            link: "https://notion.so",
            description: "All in one too to organize teams and ideas. Write, plan, collaborate, and get organized.",
            tags: ["#organization", "#planning", "#collaboration", "#writing"]
        )
    }

    static var mockWithInvalidLink: GetUsefulToolsUseCaseModels.Tool {
        .init(
            id: .zero,
            title: "Notion",
            link: "",
            description: "All in one too to organize teams and ideas. Write, plan, collaborate, and get organized.",
            tags: ["#organization", "#planning", "#collaboration", "#writing"]
        )
    }
}
