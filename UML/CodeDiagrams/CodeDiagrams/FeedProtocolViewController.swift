//
//  FeedProtocolViewController.swift
//  CodeDiagrams
//
//  Created by Wilmer Barrios on 28/02/21.
//

import Foundation
import UIKit

protocol FeedLoadable {
    func loadFeed(completion: @escaping ([String]) -> Void)
}

class FeedProtocolViewController: UIViewController {
    
    var loader: FeedLoadable!
    
    convenience init(loader: FeedLoadable) {
        self.init()
        self.loader = loader
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loader.loadFeed { (loadedItems) in
            // Update UI
        }
    }
}

// MARK: - <FeedLoadable> implementations

class RemoteFeedLoader: FeedLoadable {
    func loadFeed(completion: @escaping ([String]) -> Void) {
        // Url request... do something
    }
}

class LocalFeedLoader: FeedLoadable {
    func loadFeed(completion: @escaping ([String]) -> Void) {
        // File system, CoreData... do something
    }
}

struct Reachability {
    static let networkAvailable = false
}

class RemoteWithLocalFallbackFeedLoader: FeedLoadable {
    let remote: RemoteFeedLoader
    let local: LocalFeedLoader
    
    init(remote: RemoteFeedLoader, local: LocalFeedLoader) {
        self.remote = remote
        self.local = local
    }
    
    func loadFeed(completion: @escaping ([String]) -> Void) {
        if Reachability.networkAvailable {
            remote.loadFeed(completion: completion)
        } else {
            local.loadFeed(completion: completion)
        }
    }
}
