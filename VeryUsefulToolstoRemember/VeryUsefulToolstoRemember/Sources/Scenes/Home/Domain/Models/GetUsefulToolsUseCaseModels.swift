//
//  GetUsefulToolsUseCaseModels.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 01/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation

enum GetUsefulToolsUseCaseError: Error {
    case genericError
}

enum GetUsefulToolsUseCaseModels {
    struct Tool {
        let id: UInt
        let title: String
        let link: String?
        let description: String
        let tags: [String]
    }
}
