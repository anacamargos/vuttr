//
//  ToolsRequest.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 14/04/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation

enum ToolsRequest: NetworkRequest {

    case getTools
    case createNewTool(CreateNewToolParameters)
    case deleteTool(id: UInt)
    case searchTools(SearchToolParameters)

    var baseURL: BaseURL { .serviceGroup(.vuttr) }

    var path: String? {
        switch self {
        case .getTools, .createNewTool, .searchTools:
            return "/tools"
        case let .deleteTool(id):
            return "/tools/\(id)"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getTools, .searchTools:
            return .get
        case .createNewTool:
            return .post
        case .deleteTool:
            return .delete
        }
    }

    var httpBody: HTTPBody? {
        switch self {
        case let .createNewTool(parameters):
            return .json((try? parameters.toJSON()) ?? [:])
        default:
            return nil
        }
    }

    var urlParameters: URLParameters? {
        switch self {
        case let .searchTools(parameters):
            return .raw(["q": parameters.text])
        default:
            return nil
        }
    }
}
