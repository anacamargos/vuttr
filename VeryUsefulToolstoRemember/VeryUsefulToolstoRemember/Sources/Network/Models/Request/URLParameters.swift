//
//  URLParameters.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 02/04/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation

/// Defines which kind of parameters are to be added to on the URL, as a QueryParameter.
enum URLParameters {
    /// - raw: means that the data can be added as is.
    case raw([String: String])
}
