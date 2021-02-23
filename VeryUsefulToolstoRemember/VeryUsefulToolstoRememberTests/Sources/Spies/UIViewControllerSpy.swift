//
//  UIViewControllerSpy.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 23/02/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import UIKit

final class UIViewControllerSpy: UIViewController {
    
    private(set) var presentCalled = false
    private(set) var viewControllerToPresentPassed: UIViewController?
    private(set) var presentAnimatedFlagPassed: Bool?
    private(set) var presentCompletionPassed: (() -> Void)?
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentCalled = true
        viewControllerToPresentPassed = viewControllerToPresent
        presentAnimatedFlagPassed = flag
        presentCompletionPassed = completion
    }
    
    private(set) var dismissCalled = false
    private(set) var dismissAnimatedFlagPassed: Bool?
    private(set) var dismissCompletionPassed: (() -> Void)?
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        dismissCalled = true
        dismissAnimatedFlagPassed = flag
        dismissCompletionPassed = completion
    }
}
