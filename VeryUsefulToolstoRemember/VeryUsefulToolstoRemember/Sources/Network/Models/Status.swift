//
//  Status.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 24/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation

enum Status {
    typealias RawValue = Int
    
    case http(Int)
    case internalError(InternalError)
    
    var rawValue: Status.RawValue {
        switch self {
        case let .http(code):
            return code
        case let .internalError(code):
            return code.rawValue
        }
    }
}

extension Status {
    enum InternalError {
        typealias RawValue = Int
        
        case unexpected
        case couldNotConnectToNetwork
        case noInternetConnection
        case apiErrorParsing
        case jsonParsing
        case invalidHTTPResponse
        case httpServiceUnavailable
        case objectDecoding
        case invalidBaseURL
        case invalidHTTPBody
        case unexpectedHTTPError(HTTPURLResponse, Error?, Data?)
        
        var rawValue: Int {
            switch self {
            case .httpServiceUnavailable:
                return 503
            case .unexpected:
                return 1001
            case .couldNotConnectToNetwork:
                return 1002
            case .noInternetConnection:
                return 1003
            case .apiErrorParsing:
                return 1004
            case .jsonParsing:
                return 1005
            case .invalidHTTPResponse:
                return 1006
            case .objectDecoding:
                return 1007
            case .invalidBaseURL:
                return 1008
            case .invalidHTTPBody:
                return 1009
            case .unexpectedHTTPError:
                return 1010
            }
        }
    }
}

// MARK: - Internal Error Conformances

extension Status.InternalError: CustomNSError {
    static var errorDomain: String { "Network:Error:Internal" }
    var errorCode: Int { rawValue }
    var errorUserInfo: [String: Any] {
        switch self {
        case let .unexpectedHTTPError(httpURLResponse, error, data):
            var userInfo = [String: Any]()
            userInfo["httpResponse"] = httpURLResponse
            userInfo["error"] = error
            userInfo["data"] = data
            return userInfo
        default:
            return ["info": String(describing: self)]
        }
    }
}
