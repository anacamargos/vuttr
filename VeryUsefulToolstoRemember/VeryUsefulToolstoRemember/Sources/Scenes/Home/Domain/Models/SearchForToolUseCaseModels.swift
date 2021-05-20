//
//  SearchForToolUseCaseModels.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 20/05/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation

enum SearchForToolUseCaseError: Error {
    case genericError
}

enum SearchForToolUseCaseModels {

    struct Request {
        let text: String
    }
}
