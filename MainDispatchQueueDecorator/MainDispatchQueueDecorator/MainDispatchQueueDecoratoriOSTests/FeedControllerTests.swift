//
//  FeedControllerTests.swift
//  MainDispatchQueueDecoratoriOSTests
//
//  Created by Wilmer Barrios on 05/05/21.
//

import UIKit
import XCTest
import MainDispatchQueueDecorator

final class FeedController: UITableViewController {
    private var loader: FeedLoader?
    
    convenience init(loader: FeedLoader) {
        self.init()
        self.loader = loader
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
    }
    
    private func load() {
        loader?.load(completion: {_ in })
    }
}

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
    
    // MARK: Helpers
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: FeedController, loader: FeedLoaderMock) {
        let loader = FeedLoaderMock()
        let sut = FeedController(loader: loader)
        trackMemoryLeaks(loader, file: file, line: line)
        trackMemoryLeaks(sut, file: file, line: line)
        return (sut, loader)
    }
    
    private func trackMemoryLeaks(_ object: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock {
            [weak object] in
            XCTAssertNil(object, "Instance should be deallocated, potential memory leak", file: file, line: line)
        }
    }
    
    private class FeedLoaderMock: FeedLoader {
        var loadRequestsCount: Int = 0
        
        func load(completion: @escaping (FeedLoader.Result) -> Void) {
            loadRequestsCount += 1
        }
    }
}
