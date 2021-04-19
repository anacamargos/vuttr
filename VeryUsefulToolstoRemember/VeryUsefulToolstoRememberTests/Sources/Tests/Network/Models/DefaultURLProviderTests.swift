//
//  DefaultURLProviderTests.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 13/04/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import XCTest
@testable import VeryUsefulToolstoRemember

final class DefaultURLProviderTests: XCTestCase {

    func test_getBaseURL_shouldReturnCorrectURL() {
        // Given
        let sut = makeSUT()
        let expectedURL = "https://api.test.com.br"

        // When
        let receivedURL = sut.getBaseURL(forServiceGroup: .vuttr)

        // Then
        XCTAssertEqual(expectedURL, receivedURL)
    }

    // MARK: - Test Helpers

    private func makeSUT() -> DefaultURLProvider {
        .init()
    }

}
