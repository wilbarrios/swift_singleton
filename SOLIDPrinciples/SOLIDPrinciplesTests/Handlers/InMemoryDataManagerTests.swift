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
        storedItems[id] = item
    }
    
    func retreive(id: String) -> InMemoryDataModel? {
        return storedItems[id]
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
    
    func test_retreiveNoDataWithNoStoredData() {
        let sut = makeSUT()
        
        let retreivedData = sut.retreive(id: makeUniqueId())
        
        XCTAssertNil(retreivedData, "Data was retreived when any data was stored")
    }
    
    // MARK: Helpers
    private func makeData() -> (id: String, item: Model) {
        let uniqueId = makeUniqueId()
        return (uniqueId, Model())
    }
    
    
    private func makeUniqueId() -> String {
        UUID().uuidString
    }
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> InMemoryDataManager {
        let sut = InMemoryDataManager()
        trackMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}

