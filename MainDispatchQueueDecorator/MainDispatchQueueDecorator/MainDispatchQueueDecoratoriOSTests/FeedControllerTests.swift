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
}

class FeedControllerTests: XCTestCase {
    func test_init_doesNotFetchFeed() {
        let loader = FeedLoaderMock()
        let _ = FeedController(loader: loader)
        
        XCTAssertEqual(loader.loadRequestsCount, 0)
    }
    
    private class FeedLoaderMock: FeedLoader {
        var loadRequestsCount: Int = 0
        
        func load(completion: @escaping (FeedLoader.Result) -> Void) {
            loadRequestsCount += 1
        }
    }
}
