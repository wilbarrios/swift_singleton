//
//  CodeDiagramsTests.swift
//  CodeDiagramsTests
//
//  Created by Wilmer Barrios on 20/02/21.
//

import XCTest
@testable import CodeDiagrams

class FeedViewControllerTests: XCTestCase {
    private typealias Item = String

    func test_initializationDoesntLoadAnyData() {
        let dummyData = [makeUniqueItem(), makeUniqueItem()]
        let sut = makeSUT(dummyData)
        XCTAssertEqual(sut.items, [])
    }
    
    func test_loadItemsOnViewDidLoad() {
        let dummyData = [makeUniqueItem(), makeUniqueItem()]
        let sut = makeSUT(dummyData)
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.items, dummyData)
    }
    
    private func makeSUT(_ items: [Item], line: UInt = #line, file: StaticString = #file) -> (FeedViewController) {
        let loader: FeedLoader = { $0(items) }
        let sut = FeedViewController(loadFeed: loader)
        trackMemoryLeaks(sut, file: file, line: line)
        return sut
    }
    
    private func trackMemoryLeaks(_ sut: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock {
            [weak sut] in
            XCTAssertNil(sut, "Potential memory leak", file: file, line: line)
        }
    }
    
    private func makeUniqueItem() -> Item {
        return "item - \(UUID().uuidString)"
    }

}
