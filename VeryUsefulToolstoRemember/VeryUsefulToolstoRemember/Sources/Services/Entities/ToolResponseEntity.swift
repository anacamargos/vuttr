//
//  ToolResponseEntity.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 14/04/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation

struct ToolResponseEntity: Codable {
    let id: UInt
    let title: String
    let link: String
    let description: String
    let tags: [String]
}
