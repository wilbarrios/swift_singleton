//
//  InMemoryDataManagerTests.swift
//  SOLIDPrinciplesTests
//
//  Created by Wilmer Barrios on 28/02/21.
//

import Foundation
import XCTest
@testable import SOLIDPrinciples

class InMemoryDataManager {
    var savedItems: Int = 0
}

class InMemoryDataManagerTests: XCTestCase {
    func test_initDoesnotSaveData() {
        let sut = InMemoryDataManager()
        XCTAssertEqual(sut.savedItems, 0)
    }
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> InMemoryDataManager {
        let sut = InMemoryDataManager()
        trackMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}

