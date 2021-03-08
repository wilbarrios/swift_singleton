//
//  SinglePlayerViewController.swift
//  ModularStoryboardApp
//
//  Created by Wilmer Barrios on 07/03/21.
//

import Foundation
import UIKit

class SinglePlayerViewController: UIViewController {
    
    private var playerScoreView: PlayerScoreViewController? {
        children.compactMap({ $0 as? PlayerScoreViewController }).first
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerScoreView?.playerName = "Wilmer Barrios"
    }
}
