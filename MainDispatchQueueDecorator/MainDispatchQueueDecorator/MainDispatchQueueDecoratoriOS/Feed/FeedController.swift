//
//  FeedController.swift
//  MainDispatchQueueDecoratoriOS
//
//  Created by Wilmer Barrios on 06/05/21.
//

import Foundation
import MainDispatchQueueDecorator
import UIKit

final class FeedController: UITableViewController {
    private var loader: FeedLoader?
    private var data = [FeedItem]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    convenience init(loader: FeedLoader) {
        self.init()
        self.loader = loader
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        load()
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: FeedController.cellIdentifier)
    }
    
    private func load() {
        loader?.load(completion: {
            [weak self] result in
            if let _data = try? result.get() {
                self?.data = _data
            }
        })
    }
    
    // MARK: Table extension
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    private static var cellIdentifier: String { "cell" }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedController.cellIdentifier, for: indexPath)
        let row = indexPath.row
        cell.textLabel?.text = data[row].name
        return cell
    }
}
