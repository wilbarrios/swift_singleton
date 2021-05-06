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
        let loader = FeedLoaderMock()
        let _ = FeedController(loader: loader)
        
        XCTAssertEqual(loader.loadRequestsCount, 0)
    }
    
    func test_viewDidLoad_fetchesFeedAutomatically() {
        let loader = FeedLoaderMock()
        let sut = FeedController(loader: loader)
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(loader.loadRequestsCount, 1)
    }
    
    private class FeedLoaderMock: FeedLoader {
        var loadRequestsCount: Int = 0
        
        func load(completion: @escaping (FeedLoader.Result) -> Void) {
            loadRequestsCount += 1
        }
    }
}
