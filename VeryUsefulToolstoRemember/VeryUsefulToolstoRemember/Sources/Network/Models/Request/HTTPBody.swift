//
//  HTTPBody.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 02/04/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation

/// Defines what can be added to the HTTPBody parameter of the request.
enum HTTPBody {
    case data(Data)
    case dictionary([String: Any])
    case json(Any)
    case formUrlEncoded([String: Any])
}
