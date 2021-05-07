//
//  FeedControllerTests.swift
//  MainDispatchQueueDecoratoriOSTests
//
//  Created by Wilmer Barrios on 05/05/21.
//

import UIKit
import XCTest
import MainDispatchQueueDecorator
@testable import MainDispatchQueueDecoratoriOS

class FeedControllerTests: XCTestCase {
    func test_init_doesNotFetchFeed() {
        let (_, loader) = makeSUT()
        
        XCTAssertEqual(loader.loadRequestsCount, 0)
    }
    
    func test_viewDidLoad_fetchesFeedAutomatically() {
        let (sut, loader) = makeSUT()
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(loader.loadRequestsCount, 1)
    }
    
    func test_loadSucceed_rendersItems() {
        let (sut, loader) = makeSUT()
        
        let data = [makeItem(name: "ItemOne"), makeItem(name: "ItemTwo")]
        
        assert(sut, renders: data) {
            loader.complete(result: .success(data))
        }
    }
     
    // MARK: Helpers
    private static var TABLE_SECTION: Int { 0 }
    
    private func assert(_ sut: FeedController, renders items: [FeedItem], action: @escaping (() -> Void), file: StaticString = #file, line: UInt = #line) {
        sut.loadViewIfNeeded()
        
        let dataSource: UITableViewDataSource = sut.tableView.dataSource!
        let tableView: UITableView = sut.tableView!
        
        action()
        
        for (i, item) in items.enumerated() {
            let cell = dataSource.tableView(tableView, cellForRowAt: IndexPath(row: i, section: FeedControllerTests.TABLE_SECTION))
            XCTAssertEqual(cell.textLabel?.text, item.name, file: file, line: line)
        }
    }
    
    private func makeItem(name: String = "itemName") -> FeedItem {
        FeedItem(name: name)
    }
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: FeedController, loader: FeedLoaderMock) {
        let loader = FeedLoaderMock()
        let sut = FeedController(loader: loader)
        trackMemoryLeaks(loader, file: file, line: line)
        trackMemoryLeaks(sut, file: file, line: line)
        return (sut, loader)
    }
}
