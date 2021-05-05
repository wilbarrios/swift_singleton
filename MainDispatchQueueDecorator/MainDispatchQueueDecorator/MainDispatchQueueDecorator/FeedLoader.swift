//
//  FeedLoader.swift
//  MainDispatchQueueDecorator
//
//  Created by Wilmer Barrios on 04/05/21.
//

import Foundation

public struct FeedItem { }

public protocol FeedLoader {
    typealias Result = Swift.Result<[FeedItem], Error>
    func load(completion: @escaping (Result) -> Void)
}
