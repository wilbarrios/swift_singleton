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

// MARK: - RemoteFeedLoader <FeedLoadable> implementation

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
