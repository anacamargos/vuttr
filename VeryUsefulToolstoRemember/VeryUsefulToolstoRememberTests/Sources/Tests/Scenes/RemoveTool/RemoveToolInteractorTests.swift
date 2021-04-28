//
//  RemoveToolInteractorTests.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 10/03/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import XCTest
@testable import VeryUsefulToolstoRemember

final class RemoveToolInteractorTests: XCTestCase {

    func test_onViewDidLoad_shouldCallCorrectMethodInPresenterWithCorrectParameters() {
        // Given
        let presenterSpy = RemoveToolPresenterSpy()
        let mockParameter = RemoveToolSceneParameters.mock
        let sut = makeSUT(presenter: presenterSpy, parameters: mockParameter)

        // When
        sut.onViewDidLoad()

        // Then
        XCTAssertEqual(String(describing: presenterSpy.presentToolNamePassedToolName), String(describing: [mockParameter.toolName]))
    }

    // MARK: - Test Helpers

    private func makeSUT(
        presenter: RemoveToolPresentationLogic = RemoveToolPresenterDummy(),
        parameters: RemoveToolSceneParameters = .mock,
        deleteToolUseCase: DeleteToolUseCaseProvider = DeleteToolUseCaseDummy(),
        file: StaticString = #file,
        line: UInt = #line
    ) -> RemoveToolInteractor {
        let sut = RemoveToolInteractor(
            presenter: presenter,
            parameters: parameters,
            deleteToolUseCase: deleteToolUseCase
        )
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}
