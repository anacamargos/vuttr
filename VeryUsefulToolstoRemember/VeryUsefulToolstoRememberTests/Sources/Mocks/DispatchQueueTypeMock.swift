//
//  DispatchQueueTypeMock.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 30/04/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation
@testable import VeryUsefulToolstoRemember

final class DispatchQueueTypeMock: DispatchQueueType {
    func async(execute work: @escaping () -> Void) {
        work()
    }
}
