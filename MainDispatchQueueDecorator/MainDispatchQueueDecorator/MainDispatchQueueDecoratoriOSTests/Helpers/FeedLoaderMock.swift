//
//  FeedLoaderMock.swift
//  MainDispatchQueueDecoratoriOSTests
//
//  Created by Wilmer Barrios on 06/05/21.
//

import Foundation
import MainDispatchQueueDecorator

final class FeedLoaderMock: FeedLoader {
    var loadRequestsCount: Int {
        completions.count
    }
    
    private var completions = [((FeedLoader.Result) -> Void)]()
    
    // Helpers
    func complete(result: FeedLoader.Result, index: Int = 0) {
        completions[index](result)
    }
    
    // Extension
    func load(completion: @escaping (FeedLoader.Result) -> Void) {
        completions.append(completion)
    }
}
