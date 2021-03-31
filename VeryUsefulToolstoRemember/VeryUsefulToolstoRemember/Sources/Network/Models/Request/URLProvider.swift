//
//  ServiceGroup.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 31/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation

/// Defines a service group to provide URLs
/// A ServiceGroup is a sum of endpoints that exist on the applications context.
public enum ServiceGroup {
    case vuttr
}

/// Defines a  provider of URLs
public protocol URLProvider {
    /// Returns a baseURL string acording to the  ServiceGroup
    /// - Parameters:
    ///   - group: a service group that defines the URL
    func getBaseURL(
        forServiceGroup group: ServiceGroup
    ) -> String
}

public final class DefaultURLProvider: URLProvider {
    
    // MARK: - Constants
    
    private let https = "https://"
    
    // MARK: - Initialization
    
    public init() {}

    // MARK: - Public Functions
    
    public func getBaseURL(
        forServiceGroup group: ServiceGroup
    ) -> String {
        var url: String

        switch group {
        case .vuttr:
            url = getVuttrURL()
        }
        return https + url
    }
    
    // MARK: - Private Methods
    
    private func getVuttrURL() -> String {
        return "api.test.com.br"
    }
}
