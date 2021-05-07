//
//  FeedUIIntegrationTests.swift
//  MainDispatchQueueDecoratoriOSTests
//
//  Created by Wilmer Barrios on 06/05/21.
//

import Foundation
import UIKit
import XCTest
import MainDispatchQueueDecorator

protocol FeedUIFactory {
    func makeFeedController() -> UIViewController
}

final class UIKitFeedUIFactory: FeedUIFactory {
    private let loader: FeedLoader
    
    init(loader: FeedLoader) {
        self.loader = loader
    }
    
    func makeFeedController() -> UIViewController {
        return FeedController(loader: loader)
    }
}

class WeakRef<T> {
    private let decoratee: T
    
    init(_ decoratee: T) {
        self.decoratee = decoratee
    }
    
    func dispatch(_ completion: @escaping (() -> Void)) {
        guard Thread.isMainThread else { DispatchQueue.main.async(execute: completion); return }
        completion()
    }
}

extension WeakRef: FeedLoader where T: FeedLoader {
    func load(completion: @escaping (FeedLoader.Result) -> Void) {
        decoratee.load { [weak self] (result) in
            self?.dispatch { completion(result) }
        }
    }
}

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
