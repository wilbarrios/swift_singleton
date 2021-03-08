//
//  MultiplayerViewController.swift
//  ModularStoryboardApp
//
//  Created by Wilmer Barrios on 07/03/21.
//

import Foundation
import UIKit

final class MultiplayerViewController: UIViewController {
    private var playerOneController: PlayerScoreViewController? {
        playersScoreViewControllers?.first
    }
    
    private var playerTwoController: PlayerScoreViewController? {
        playersScoreViewControllers?.last
    }
    
    private var playersScoreViewControllers: [PlayerScoreViewController]? {
        children.compactMap({ $0 as? PlayerScoreViewController })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerOneController?.playerName = "Wilmer Barrios"
        playerTwoController?.playerName = "Jhon Doe"
    }
}
