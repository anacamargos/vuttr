//
//  JSONConvertible.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 03/05/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation

protocol JSONConvertible {
    func toJSON(
        using encoder: JSONEncoder,
        serializer: JSONSerialization.Type
    ) throws -> [String: Any]?
}

extension JSONConvertible where Self: Encodable {
    func toJSON(
        using encoder: JSONEncoder = .init(),
        serializer: JSONSerialization.Type = JSONSerialization.self
    ) throws -> [String: Any]? {
        let data = try encoder.encode(self)
        let jsonValue = try serializer.jsonObject(with: data, options: .allowFragments)
        let json = jsonValue as? [String: Any]
        return json
    }
}
