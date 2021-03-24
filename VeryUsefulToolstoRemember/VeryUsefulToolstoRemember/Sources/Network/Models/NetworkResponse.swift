//
//  NetworkResponse.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 24/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation

/// Constrains the response and the status code.
struct NetworkResponse {
    
    let status: Status
    let data: Data?
    
    init(
        status: Status,
        data: Data?
    ) {
        self.status = status
        self.data = data
    }
}
