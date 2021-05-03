//
//  CreateNewToolParameters.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 03/05/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation

struct CreateNewToolParameters: Codable, JSONConvertible {
    let title: String
    let link: String
    let description: String
    let tags: [String]
}
