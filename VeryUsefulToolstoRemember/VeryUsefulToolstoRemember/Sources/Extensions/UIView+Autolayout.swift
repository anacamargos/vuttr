//
//  UIView+Autolayout.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 23/12/20.
//

import UIKit

extension UIView {
    /// Add anchors from any side of the current view into the specified anchors and returns the newly added constraints.
    ///
    /// - Parameters:
    ///   - top: current view's top anchor will be anchored into the specified anchor
    ///   - left: current view's left anchor will be anchored into the specified anchor
    ///   - bottom: current view's bottom anchor will be anchored into the specified anchor
    ///   - right: current view's right anchor will be anchored into the specified anchor
    ///   - topConstant: current view's top anchor margin
    ///   - leftConstant: current view's left anchor margin
    ///   - bottomConstant: current view's bottom anchor margin
    ///   - rightConstant: current view's right anchor margin
    ///   - widthConstant: current view's width
    ///   - heightConstant: current view's height
    /// - Returns: array of newly added constraints (if applicable).
    @discardableResult
    func anchor(
        top: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        right: NSLayoutXAxisAnchor? = nil,
        topConstant: CGFloat = 0,
        leftConstant: CGFloat = 0,
        bottomConstant: CGFloat = 0,
        rightConstant: CGFloat = 0,
        widthConstant: CGFloat = 0,
        heightConstant: CGFloat = 0
    ) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false

        var anchors = [NSLayoutConstraint]()

        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }

        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }

        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }

        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }

        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }

        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }

        anchors.forEach({ $0.isActive = true })

        return anchors
    }
    
    /// makes the view to fill the entire superview.
    func fillSuperview() {
        anchor(
            top: superview?.topAnchor,
            left: superview?.leftAnchor,
            bottom: superview?.bottomAnchor,
            right: superview?.rightAnchor
        )
    }

    /// Anchor center X into current view's superview with a constant margin value.
    ///
    /// - Parameter constant: constant of the anchor constraint (default is 0).
    func anchorCenterXToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }

    /// Anchor center Y into current view's superview with a constant margin value.
    ///
    /// - Parameter withConstant: constant of the anchor constraint (default is 0).
    func anchorCenterYToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }

    /// Anchor center X and Y into current view's superview
    func anchorCenterSuperview() {
        anchorCenterXToSuperview()
        anchorCenterYToSuperview()
    }

    /// Returns the `safeAreaLayoutGuide.bottomAnchor`, if available,
    /// otherwhise, returns `bottomAnchor`
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        return safeAreaLayoutGuide.bottomAnchor
    }

    /// Returns the `safeAreaLayoutGuide.topAnchor`, if available,
    /// otherwhise, returns `topAnchor`
    var safeTopAnchor: NSLayoutYAxisAnchor {
        return safeAreaLayoutGuide.topAnchor
    }

    /// Simplifies layouting with a constraint array
    /// - Parameter constraints: the constraints to apply to the view
    func layout(using constraints: [NSLayoutConstraint]) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
}

