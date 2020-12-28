//
//  UITableViewExtensions.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 28/12/20.
//  Copyright © 2020 Ana Letícia Camargos. All rights reserved.
//

import UIKit

extension UITableView {
    
    func reusableCell<T: UITableViewCell>(for identifier: String, for indexPath: IndexPath) -> T {
        if let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T {
            return cell
        }
        
        return T()
    }
}
