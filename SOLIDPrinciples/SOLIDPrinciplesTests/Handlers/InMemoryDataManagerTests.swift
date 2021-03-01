//
//  InMemoryDataManagerTests.swift
//  SOLIDPrinciplesTests
//
//  Created by Wilmer Barrios on 28/02/21.
//

import Foundation
import XCTest
@testable import SOLIDPrinciples

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
    
    func test_retreiveCorrectDataForExpectedIds() {
        let sut = makeSUT()
        
        let data1 = makeData()
        let data2 = makeData()
        storeItems(sut, items: [data1, data2])
        
        XCTAssertEqual(sut.retreive(id: data1.id), data1.item)
        XCTAssertEqual(sut.retreive(id: data2.id), data2.item)
    }
    
    // MARK: Helpers
    private func storeItems(_ sut: InMemoryDataManager, items: [(id: String, item: Model)]) {
        items.forEach({ sut.store(id: $0.id, item: $0.item) })
    }
    
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

