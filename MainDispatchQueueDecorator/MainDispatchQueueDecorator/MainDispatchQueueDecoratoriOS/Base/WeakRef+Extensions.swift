//
//  WeakRef+Extensions.swift
//  MainDispatchQueueDecoratoriOS
//
//  Created by Wilmer Barrios on 06/05/21.
//

import Foundation
import MainDispatchQueueDecorator

extension WeakRef: FeedLoader where T: FeedLoader {
    public func load(completion: @escaping (FeedLoader.Result) -> Void) {
        decoratee.load { [weak self] (result) in
            self?.dispatch { completion(result) }
        }
    }
}
