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
        case plusCircle = "plus-circle"
    }
    
    class var close: UIImage { UIImage(.close)! }
    class var plusCircle: UIImage { UIImage(.plusCircle)! }
    
    convenience init?(_ resource: Resource) {
        self.init(
            named: resource.rawValue
        )
    }
}

