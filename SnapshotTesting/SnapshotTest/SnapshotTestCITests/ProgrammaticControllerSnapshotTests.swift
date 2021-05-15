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
        
        assert(snapshot: sut.snapshot(), name: "EMPTY_CONTROLLER")
    }
    
    func test_shortText() {
        let sut = makeSUT(text: "Short text")
        
        assert(snapshot: sut.snapshot(), name: "SHORT_TEXT_CONTROLLER")
    }
    
    // MARK: Helpers
    private func makeSUT(text: String? = nil) -> ProgrammaticController {
        return ProgrammaticController(text: text ?? "")
    }
    
    private func record(snapshot: UIImage, name: String, file: StaticString = #file, line: UInt = #line) {
        guard let snapshotData = snapshot.pngData() else {
            XCTFail("Failed to generate PNG data representation from snapshot", file: file, line: line)
            return
        }
        
        // ../SnapshotTestCITests/snapshots/[name].png
        let snapshotURL = URL(fileURLWithPath: String(describing: file))
            .deletingLastPathComponent()
            .appendingPathComponent("snapshots")
            .appendingPathComponent("\(name).png")
        
        do {
            try FileManager.default.createDirectory(at: snapshotURL.deletingLastPathComponent(), withIntermediateDirectories: true)
            try snapshotData.write(to: snapshotURL)
        } catch {
            XCTFail("Failed to record snapshot with error: \(error)", file: file, line: line)
        }
    }
    
    private func assert(snapshot: UIImage, name: String, file: StaticString = #file, line: UInt = #line) {
        guard let snapshotData = snapshot.pngData() else {
            XCTFail("Failed to generate PNG data representation from snapshot", file: file, line: line)
            return
        }
        
        // ../SnapshotTestCITests/snapshots/[name].png
        let snapshotURL = URL(fileURLWithPath: String(describing: file))
            .deletingLastPathComponent()
            .appendingPathComponent("snapshots")
            .appendingPathComponent("\(name).png")
        
        
        guard let storedSnapshotData = try? Data(contentsOf: snapshot) else {
            XCTFail("Failed to load stored snapshot at URL: \(snapshotURL). Use `record` method to store a snapshot before asserting.", file: file, line: line)
            return
        }
        
        if snapshotData != storedSnapshotData {
            let temporaryURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true).appendingPathComponent(snapshotURL.lastPathComponent)
            
            try? snapshotData.write(to: temporaryURL)
            
            XCTFail("New snapshot does not match sotred snapshot. New snapshot URL: \(temporaryURL), Stored snapshot URL: \(snapshotURL)", file: file, line: line)
        }
        
        do {
            try FileManager.default.createDirectory(at: snapshotURL.deletingLastPathComponent(), withIntermediateDirectories: true)
            try snapshotData.write(to: snapshotURL)
        } catch {
            XCTFail("Failed to record snapshot with error: \(error)", file: file, line: line)
        }
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
