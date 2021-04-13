//
//  UICollectionViewExtensions.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 24/02/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import UIKit

extension UICollectionView {
    func reusableCell<T: UICollectionViewCell>(for type: T.Type, indexPath: IndexPath) -> T {
        if let cell = dequeueReusableCell(withReuseIdentifier: T.className, for: indexPath) as? T {
            return cell
        }
        return T()
    }
}
