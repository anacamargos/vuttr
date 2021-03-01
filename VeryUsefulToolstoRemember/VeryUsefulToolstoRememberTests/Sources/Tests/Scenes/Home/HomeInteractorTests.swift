//
//  HomeInteractorTests.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 01/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import XCTest
@testable import VeryUsefulToolstoRemember

final class HomeInteractorTests: XCTestCase {
    
    func test_onViewDidLoad_whenUseCaseSucceeds_shouldCallCorrectMethodInPresenterWithCorrectParameters() {
        // Given
        let useCaseStub = GetUsefulToolsUseCaseStub()
        useCaseStub.executeResultToBeReturned = .success([.mock])
        let presenterSpy = HomePresenterSpy()
        let sut = makeSUT(presenter: presenterSpy, getToolsUseCase: useCaseStub)
        let expectedResponse = Home.UsefulTools.Response.content([.mock])
        
        // When
        sut.onViewDidLoad()
        
        // Then
        XCTAssertEqual(String(describing: presenterSpy.presentToolsResponsePassedResponses), String(describing: [.loading, expectedResponse]))
    }
    
    func test_onViewDidLoad_whenUseCaseFails_shouldCallCorrectMethodInPresenterWithCorrectParameters() {
        // Given
        let useCaseStub = GetUsefulToolsUseCaseStub()
        useCaseStub.executeResultToBeReturned = .failure(.genericError)
        let presenterSpy = HomePresenterSpy()
        let sut = makeSUT(presenter: presenterSpy, getToolsUseCase: useCaseStub)
        let expectedResponse = Home.UsefulTools.Response.error
        
        // When
        sut.onViewDidLoad()
        
        // Then
        XCTAssertEqual(String(describing: presenterSpy.presentToolsResponsePassedResponses), String(describing: [.loading, expectedResponse]))

    }

    // MARK: - Test Helpers
    
    private func makeSUT(
        presenter: HomePresentationLogic = HomePresenterDummy(),
        getToolsUseCase: GetUsefulToolsUseCaseProvider = GetUsefulToolsUseCaseDummy()
    ) -> HomeInteractor {
        .init(
            presenter: presenter,
            getToolsUseCase: getToolsUseCase
        )
    }

}

final class HomePresenterDummy: HomePresentationLogic {
    func presentToolsResponse(_ response: Home.UsefulTools.Response) {}
}

final class GetUsefulToolsUseCaseDummy: GetUsefulToolsUseCaseProvider {
    func execute(then handle: @escaping (Result<[GetUsefulToolsUseCaseModels.Tool], GetUsefulToolsUseCaseError>) -> Void) {}
}

final class HomePresenterSpy: HomePresentationLogic {
    
    private(set) var presentToolsResponsePassedResponses = [Home.UsefulTools.Response]()
    
    func presentToolsResponse(_ response: Home.UsefulTools.Response) {
        presentToolsResponsePassedResponses.append(response)
    }
}

final class GetUsefulToolsUseCaseStub: GetUsefulToolsUseCaseProvider {
    
    var executeResultToBeReturned: Result<[GetUsefulToolsUseCaseModels.Tool], GetUsefulToolsUseCaseError> = .success([.mock])
    
    func execute(then handle: @escaping (Result<[GetUsefulToolsUseCaseModels.Tool], GetUsefulToolsUseCaseError>) -> Void) {
        handle(executeResultToBeReturned)
    }
}
