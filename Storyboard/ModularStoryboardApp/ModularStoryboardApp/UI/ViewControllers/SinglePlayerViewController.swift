//
//  SinglePlayerViewController.swift
//  ModularStoryboardApp
//
//  Created by Wilmer Barrios on 07/03/21.
//

import Foundation
import UIKit

class SinglePlayerViewController: UIViewController {
    
    var playerScoreView: PlayerScoreViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerScoreView?.playerName = "Wilmer Barrios"
    }
}
