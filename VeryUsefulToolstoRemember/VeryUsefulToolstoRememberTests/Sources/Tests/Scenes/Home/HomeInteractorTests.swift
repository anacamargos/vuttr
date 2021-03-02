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
    
    func test_handleToolSelection_whenSelectedToolIsValid_shouldCallCorrectMethodInPresenterWithCorrectParameters() {
        // Given
        let useCaseStub = GetUsefulToolsUseCaseStub()
        useCaseStub.executeResultToBeReturned = .success([.mock])
        let presenterSpy = HomePresenterSpy()
        let sut = makeSUT(presenter: presenterSpy, getToolsUseCase: useCaseStub)
        let expectedURL = URL(string: "https://notion.so")!
        
        // When
        sut.onViewDidLoad()
        sut.handleToolSelection(at: .zero)
        
        // Then
        XCTAssertEqual(presenterSpy.presentURLPassedURLs, [expectedURL])
    }
    
    func test_handleToolSelection_whenSelectedToolIsNotValid_shouldCallNotCallMethodInPresenter() {
        // Given
        let presenterSpy = HomePresenterSpy()
        let sut = makeSUT(presenter: presenterSpy)
        
        // When
        sut.handleToolSelection(at: .zero)
        
        // Then
        XCTAssertEqual(presenterSpy.presentURLPassedURLs, [])
    }
    
    func test_handleToolSelection_whenSelectedToolIsValidButURLIsNotValid_shouldCallNotCallMethodInPresenter() {
        // Given
        let useCaseStub = GetUsefulToolsUseCaseStub()
        useCaseStub.executeResultToBeReturned = .success([.mockWithInvalidLink])
        let presenterSpy = HomePresenterSpy()
        let sut = makeSUT(presenter: presenterSpy, getToolsUseCase: useCaseStub)

        // When
        sut.onViewDidLoad()
        sut.handleToolSelection(at: .zero)
        
        // Then
        XCTAssertEqual(presenterSpy.presentURLPassedURLs, [])
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
