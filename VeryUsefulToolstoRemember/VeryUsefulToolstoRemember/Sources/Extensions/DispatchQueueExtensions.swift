//
//  DispatchQueueExtensions.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 30/04/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation

protocol DispatchQueueType {
    func async(execute work: @escaping () -> Void)
}

extension DispatchQueue: DispatchQueueType {
    func async(execute work: @escaping () -> Void) {
        async(group: nil, qos: .unspecified, flags: [], execute: work)
    }
}
