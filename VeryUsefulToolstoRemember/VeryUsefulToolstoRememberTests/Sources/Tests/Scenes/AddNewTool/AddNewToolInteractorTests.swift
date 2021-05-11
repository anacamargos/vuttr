//
//  AddNewToolInteractorTests.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 11/05/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import XCTest
@testable import VeryUsefulToolstoRemember

final class AddNewToolInteractorTests: XCTestCase {

    // MARK: - Private Methods

    private func makeSUT(
        presenter: AddNewToolPresentationLogic = AddNewToolPresenterDummy(),
        createNewToolUseCase: CreateNewToolUseCaseProvider = CreateNewToolUseCaseDummy()
    ) -> AddNewToolInteractor {
        .init(presenter: presenter, createNewToolUseCase: createNewToolUseCase)
    }

}

final class AddNewToolPresenterDummy: AddNewToolPresentationLogic {
    func presentToolsResponse(_ response: AddNewTool.Response) {}
}

final class AddNewToolPresenterSpy: AddNewToolPresentationLogic {

    private(set) var presentToolsResponsePassedResponses = [AddNewTool.Response]()

    func presentToolsResponse(_ response: AddNewTool.Response) {
        presentToolsResponsePassedResponses.append(response)
    }
}

final class CreateNewToolUseCaseDummy: CreateNewToolUseCaseProvider {
    func execute(request: AddNewTool.Request, then handle: @escaping (Result<GetUsefulToolsUseCaseModels.Tool, CreateNewToolUseCaseError>) -> Void) {}
}

final class CreateNewToolUseCaseStub: CreateNewToolUseCaseProvider {
    
    var executeResultToBeReturned: Result<GetUsefulToolsUseCaseModels.Tool, CreateNewToolUseCaseError> = .success(.mock)
    
    func execute(request: AddNewTool.Request, then handle: @escaping (Result<GetUsefulToolsUseCaseModels.Tool, CreateNewToolUseCaseError>) -> Void) {
        handle(executeResultToBeReturned)
    }
}
