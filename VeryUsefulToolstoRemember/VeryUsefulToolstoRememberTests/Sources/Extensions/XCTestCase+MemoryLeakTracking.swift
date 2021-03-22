//
//  XCTestCase+MemoryLeakTracking.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 22/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}
