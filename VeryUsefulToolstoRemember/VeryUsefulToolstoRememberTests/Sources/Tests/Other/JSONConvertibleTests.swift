//
//  JSONConvertibleTests.swift
//  VeryUsefulToolstoRememberTests
//
//  Created by Ana Leticia Camargos on 03/05/21.
//  Copyright © 2021 Ana Letícia Camargos. All rights reserved.
//

import XCTest
@testable import VeryUsefulToolstoRemember

final class JSONConvertibleTests: XCTestCase {

    func test_whenCodableIsValid_jsonConvertibleShouldReturnExpectedDictionary() {
        // Given
        let expectedDictionary = ["key": "value"]
        let mockValue = CodableMock(key: "value")

        // When
        let sut = try? mockValue.toJSON()

        // Then
        let sutValue = sut?["key"] as? String
        let expectedValue = expectedDictionary["key"]
        XCTAssertEqual(sutValue, expectedValue)
    }
}
