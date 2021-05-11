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
        
        let snapshot = sut.snapshot()
        
    }
    
    // MARK: Helpers
    private func makeSUT(text: String? = nil) -> ProgrammaticController {
        return ProgrammaticController(text: text ?? "")
    }
}

extension UIViewController {
    func snapshot() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: view.bounds)
        return renderer.image { (action) in
            view.layer.render(in: action.cgContext)
        }
    }
}
