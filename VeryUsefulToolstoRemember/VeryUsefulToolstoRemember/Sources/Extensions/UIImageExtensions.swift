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
        case add
        case reloadArrow = "reload-arrow"
    }

    class var close: UIImage { UIImage(.close)! }
    class var addIcon: UIImage { UIImage(.add)! }
    class var reloadArrow: UIImage { UIImage(.reloadArrow)! }

    convenience init?(_ resource: Resource) {
        self.init(
            named: resource.rawValue
        )
    }
}
