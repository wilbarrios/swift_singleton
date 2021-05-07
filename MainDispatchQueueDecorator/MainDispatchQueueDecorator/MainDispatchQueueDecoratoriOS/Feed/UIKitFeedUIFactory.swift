//
//  UIKitFeedUIFactory.swift
//  MainDispatchQueueDecoratoriOS
//
//  Created by Wilmer Barrios on 06/05/21.
//

import UIKit
import MainDispatchQueueDecorator

public final class UIKitFeedUIFactory: FeedUIFactory {
    private let loader: FeedLoader
    
    public init(loader: FeedLoader) {
        self.loader = loader
    }
    
    public func makeFeedController() -> UIViewController {
        return FeedController(loader: loader)
    }
}
