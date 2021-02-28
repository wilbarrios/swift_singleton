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
    struct InMemoryDataModel: Equatable { }
    
    var storedItems = [String: InMemoryDataModel]()
    
    func store(id: String, item: InMemoryDataModel) {
        self.storedItems[id] = item
    }
}

class InMemoryDataManagerTests: XCTestCase {
    private typealias Model = InMemoryDataManager.InMemoryDataModel
    
    func test_initDoesnotSaveData() {
        let sut = makeSUT()
        XCTAssertEqual(sut.storedItems.count, 0)
    }
    
    func test_storeSuccessStoresExpectedItem() {
        let sut = makeSUT()
        let data = makeData()
        
        sut.store(id: data.id, item: data.item)
        
        XCTAssertEqual(sut.storedItems[data.id], data.item)
    }
    
    // MARK: Helpers
    private func makeData() -> (id: String, item: Model) {
        let uniqueId = UUID().uuidString
        return (uniqueId, Model())
    }
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> InMemoryDataManager {
        let sut = InMemoryDataManager()
        trackMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}

