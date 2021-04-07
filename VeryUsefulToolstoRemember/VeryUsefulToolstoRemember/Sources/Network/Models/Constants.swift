//
//  Constants.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 07/04/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation

enum Header {
    
    enum Key {
        static let contentType = "Content-Type"
    }

    enum ContentType {
        static let applicationJSON = "application/json"
        static let applicationJSONCharsetUTF8 = "application/json; charset=UTF-8"
        static let applicationFormURLEncoded = "application/x-www-form-urlencoded"
    }
}
