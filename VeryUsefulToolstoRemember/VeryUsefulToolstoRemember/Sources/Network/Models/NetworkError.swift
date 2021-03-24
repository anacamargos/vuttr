//
//  NetworkError.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 24/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation

struct NetworkError: Error {
    let requestError: RequestError
    let rawError: NSError?
    
    init(_ requestError: RequestError) {
        self.requestError = requestError
        rawError = nil
    }
    
    init(requestError: RequestError, rawError: Error?) {
        self.requestError = requestError
        self.rawError = rawError as NSError?
    }
}

// MARK: - RequestError Definitions

enum RequestError: Error {
    case `internal`(Internal)
    case http(HTTPCode)
}

extension RequestError {
    typealias Internal = Status.InternalError
    typealias HTTPCode = Int
}

extension RequestError: CustomNSError {
    static var errorDomain: String { "Network:Error:Request" }
    var errorCode: Int {
        switch self {
        case let .internal(internalError):
            return internalError.rawValue
        case let .http(code):
            return code
        }
    }
    
    var errorUserInfo: [String: Any] {
        switch self {
        case let .internal(internalError):
            return internalError.errorUserInfo
        case let .http(code):
            return ["code": code]
        }
    }
}
