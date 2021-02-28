//
//  FeedViewController.swift
//  CodeDiagrams
//
//  Created by Wilmer Barrios on 20/02/21.
//

import Foundation
import UIKit

typealias FeedLoader = (([String]) -> Void) -> Void

final class FeedViewController: UIViewController {
    // MARK: Dependencies
    var loadFeed: FeedLoader!
    
    // MARK: Datasource properties
    var items = [String]()
    
    // MARK: Inits
    convenience init(loadFeed: @escaping FeedLoader) {
        self.init()
        self.loadFeed = loadFeed
    }
    
    // MARK: VC Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFeed { items = $0; updateUI() } // Does not need a `self` explicit declaration.
    }
    
    // MARK: Helpers
    private func updateUI() {
        print("UI Updated with items: \(debugPrint(items))")
    }
}

