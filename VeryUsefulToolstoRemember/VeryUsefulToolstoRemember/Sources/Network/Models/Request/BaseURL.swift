//
//  BaseURL.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 31/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation

/// Defines a Base URL, which can come from a String or a Service Group
enum BaseURL {
    /// Represents a BaseURL that comes form a string
    case string(String)
    /// Represents a BaseURL that comes from a Service Group
    case serviceGroup(ServiceGroup)
}
