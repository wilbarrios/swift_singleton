//
//  HomeController.swift
//  ScrollApp
//
//  Created by Wilmer Barrios on 12/05/21.
//

import Foundation
import UIKit

class HomeController: UITableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
