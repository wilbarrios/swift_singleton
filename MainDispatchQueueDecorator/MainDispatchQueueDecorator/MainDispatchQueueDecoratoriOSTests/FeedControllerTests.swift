//
//  FeedControllerTests.swift
//  MainDispatchQueueDecoratoriOSTests
//
//  Created by Wilmer Barrios on 05/05/21.
//

import UIKit
import XCTest
import MainDispatchQueueDecorator

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

class FeedControllerTests: XCTestCase {
    func test_init_doesNotFetchFeed() {
        let (_, loader) = makeSUT()
        
        XCTAssertEqual(loader.loadRequestsCount, 0)
    }
    
    func test_viewDidLoad_fetchesFeedAutomatically() {
        let (sut, loader) = makeSUT()
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(loader.loadRequestsCount, 1)
    }
    
    func test_loadCompletesSucceed_rendersItems() {
        let (sut, loader) = makeSUT()
        let item1 = makeItem(name: "itemOne")
        let item2 = makeItem(name: "itemTwo")
        let data = [item1, item2]
        
        sut.loadViewIfNeeded()
        loader.complete(result: .success(data))
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), data.count)
    }
    
    func test_cell_rendersItemCell() {
        let (sut, loader) = makeSUT()
        let item1 = makeItem(name: "itemOne")
        let item2 = makeItem(name: "itemTwo")
        let data = [item1, item2]
        
        sut.loadViewIfNeeded()
        loader.complete(result: .success(data))
        
        let dataSource: UITableViewDataSource = sut.tableView.dataSource!
        let tableView: UITableView = sut.tableView!
        
        XCTAssertEqual(dataSource.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)).textLabel?.text, item1.name)
        XCTAssertEqual(dataSource.tableView(tableView, cellForRowAt: IndexPath(row: 1, section: 0)).textLabel?.text, item2.name)
    }
     
    // MARK: Helpers
    private func makeItem(name: String = "itemName") -> FeedItem {
        FeedItem(name: name)
    }
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: FeedController, loader: FeedLoaderMock) {
        let loader = FeedLoaderMock()
        let sut = FeedController(loader: loader)
        trackMemoryLeaks(loader, file: file, line: line)
        trackMemoryLeaks(sut, file: file, line: line)
        return (sut, loader)
    }
    
    private func trackMemoryLeaks(_ object: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock {
            [weak object] in
            XCTAssertNil(object, "Instance should be deallocated, potential memory leak", file: file, line: line)
        }
    }
    
    private class FeedLoaderMock: FeedLoader {
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
}
