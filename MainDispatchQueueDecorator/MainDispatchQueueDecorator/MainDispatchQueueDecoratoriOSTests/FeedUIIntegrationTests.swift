//
//  FeedUIIntegrationTests.swift
//  MainDispatchQueueDecoratoriOSTests
//
//  Created by Wilmer Barrios on 06/05/21.
//

import UIKit
import XCTest
import MainDispatchQueueDecorator
import MainDispatchQueueDecoratoriOS

class FeedUIIntegrationTests: XCTestCase {
    func test_loadFeed_completesInBackgroundRendersInMainThread() {
        let (sut, loader) = makeSUT()
        let vc = sut.makeFeedController()
        vc.loadViewIfNeeded()
        
        let exp = expectation(description: "Wait for background tast to complete")
        
        DispatchQueue.global().async {
            loader.complete(result: .success([FeedItem(name: "ItemOne")]))
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: UIKitFeedUIFactory, loader: FeedLoaderMock) {
        let loader = FeedLoaderMock()
        let sut = UIKitFeedUIFactory(loader: WeakRef(loader))
        trackMemoryLeaks(loader, file: file, line: line)
        trackMemoryLeaks(sut, file: file, line: line)
        return (sut, loader)
    }
}
