//
//  NSObjectExtensions.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 28/12/20.
//  Copyright © 2020 Ana Letícia Camargos. All rights reserved.
//

import Foundation

extension NSObject {
    
    static var className: String {
        return String(describing: self)
    }
}
