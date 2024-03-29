//
//  HomeController.swift
//  ScrollApp
//
//  Created by Wilmer Barrios on 12/05/21.
//

import Foundation
import UIKit

struct Option {
    let id: String
    let name: String
}

class HomeController: UITableViewController {
    
    // MARK: Events
    var onOptionSelection: ((Option) -> Void)?
    
    // MARK: DataSource
    private var options = [Option]()
    
    // MARK: Init
    convenience init(options: [Option]) {
        self.init()
        self.options = options
    }
    
    // MARK: VC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }
    
    private func setupTable() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CELL_ID)
    }
    
    // MARK: TableView
    private var CELL_ID: String { "cell" }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return makeCell(indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onOptionSelection?(optionBy(indexPath))
    }
}

// MARK: Helpers
extension HomeController {
    func optionBy(_ indexPath: IndexPath) -> Option {
        options[indexPath.row]
    }
    
    func makeCell(indexPath ip: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: ip)
        let option = options[ip.row]
        cell.selectionStyle = .none
        cell.textLabel?.text = option.id
        return cell
    }
}
