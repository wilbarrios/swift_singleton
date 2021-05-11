//
//  ProgrammaticControllerTests.swift
//  SnapshotTestTests
//
//  Created by Wilmer Barrios on 10/05/21.
//

import XCTest
@testable import SnapshotTest

class ProgrammaticControllerTests: XCTestCase {
    func test_viewDidLoad_loadLabelWithInitializedText() {
        let expectedText = "My Text"
        let sut = ProgrammaticController(text: expectedText)
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(expectedText, sut.label.text)
    }
}
