//
//  ProgrammaticControllerSnapshotTests.swift
//  SnapshotTestCITests
//
//  Created by Wilmer Barrios on 10/05/21.
//

import Foundation
import UIKit
import XCTest
@testable import SnapshotTest

class ProgrammaticControllerSnapshotTests: XCTestCase {
    func test_emptyText() {
        let sut = makeSUT()
        
        assert(snapshot: sut.snapshot(for: .iPhone8(style: .light)), named: "EMPTY_CONTROLLER")
        assert(snapshot: sut.snapshot(for: .iPhone8(style: .dark)), named: "EMPTY_CONTROLLER_DARK")
    }
    
    func test_shortText() {
        let sut = makeSUT(text: "Short text")
        
        assert(snapshot: sut.snapshot(for: .iPhone8(style: .light)), named: "SHORT_TEXT_CONTROLLER")
        assert(snapshot: sut.snapshot(for: .iPhone8(style: .dark)), named: "SHORT_TEXT_CONTROLLER_DARK")
    }
    
    // MARK: Helpers
    private func makeSUT(text: String? = nil) -> ProgrammaticController {
        return ProgrammaticController(text: text ?? "")
    }
}
