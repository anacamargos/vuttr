//
//  AddNewToolModels.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 07/05/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation

enum AddNewTool {

    struct Request {
        let toolName: String
        let toolLink: String
        let toolDescription: String
        let toolTags: [String]
    }

    enum Response {
        case success
        case error
        case loading
    }

    enum ViewState {
        case success
        case error
        case loading
    }
}
