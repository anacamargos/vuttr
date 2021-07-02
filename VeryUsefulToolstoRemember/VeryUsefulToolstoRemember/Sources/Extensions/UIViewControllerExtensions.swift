//
//  UIViewControllerExtensions.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 01/07/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import UIKit

extension UIViewController {

    private enum Constants {
        static var alertCornerRadius: CGFloat = 15.0
        static var attributedTitle: String = "attributedTitle"
    }

    func showToast(message: String, seconds: Double = 3.0) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .actionSheet)
        alert.view.layer.cornerRadius = Constants.alertCornerRadius
        let titleFont = [
            NSAttributedString.Key.font: UIFont.themeFont(for: .subtitle, weight: .semibold)
        ]
        let titleAttrStirng = NSMutableAttributedString(string: message, attributes: titleFont)
        alert.setValue(titleAttrStirng, forKey: Constants.attributedTitle)

        present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
}
