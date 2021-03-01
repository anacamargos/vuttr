//
//  GetUsefulToolsUseCase.swift
//  VeryUsefulToolstoRemember
//
//  Created by Ana Leticia Camargos on 01/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import Foundation

protocol GetUsefulToolsUseCaseProvider {
    func execute(then handle: @escaping (Result<[GetUsefulToolsUseCaseModels.Tool], GetUsefulToolsUseCaseError>) -> Void)
}

final class GetUsefulToolsUseCase: GetUsefulToolsUseCaseProvider {
    
    // MARK: - GetUsefulToolsUseCaseProvider
    
    func execute(then handle: @escaping (Result<[GetUsefulToolsUseCaseModels.Tool], GetUsefulToolsUseCaseError>) -> Void) {
        let notion = GetUsefulToolsUseCaseModels.Tool(id: 1, title: "Notion", link: "https://notion.so", description: "All in one tool to organize teams and ideas. Write, plan, collaborate, and get organized. ", tags: ["organization", "planning", "collaboration", "writing", "calendar"])
        let jsonServer = GetUsefulToolsUseCaseModels.Tool(id: 2, title: "json-server", link: "https://github.com/typicode/json-server", description: "Fake REST API based on a json schema. Useful for mocking and creating APIs for front-end devs to consume in coding challenges.", tags: ["api", "json", "schema", "node", "github", "rest"])
        let fastiky = GetUsefulToolsUseCaseModels.Tool(id: 3, title: "fastify", link: "https://www.fastify.io/", description: "Extremely fast and simple, low-overhead web framework for NodeJS. Supports HTTP2.", tags: ["web", "framework", "node", "http2", "https", "localhost"])
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            handle(.success([notion, jsonServer, fastiky]))
        }
    }
}
