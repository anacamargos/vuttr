//
//  UIImageExtensions.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 29/12/20.
//  Copyright © 2020 Ana Letícia Camargos. All rights reserved.
//

import UIKit

extension UIImage {
    
    enum Resource: String {
        case close
    }
    
    class var close: UIImage { UIImage(.close)! }
    
    convenience init?(_ resource: Resource) {
        self.init(
            named: resource.rawValue
        )
    }
}

