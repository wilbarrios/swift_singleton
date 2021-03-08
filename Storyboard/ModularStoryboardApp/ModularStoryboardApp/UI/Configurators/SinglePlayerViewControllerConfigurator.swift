//
//  SinglePlayerViewControllerConfigurator.swift
//  ModularStoryboardApp
//
//  Created by Wilmer Barrios on 07/03/21.
//

import Foundation
import UIKit


/// Class that keeps the composition logic as separated layer from storyboard or concreete `SinglePlayerViewController` implementation
final class SinglePlayerViewControllerConfigurator: NSObject {
    private var observation: NSKeyValueObservation?
    
    @IBOutlet private weak var player: UIViewController? {
        didSet {
            observation = player?.observe(\.parent, changeHandler: { player, changes in
                if let singlePlayerController = player.parent as? SinglePlayerViewController {
                    singlePlayerController.playerScoreView = player as? PlayerScoreViewController
                }
            })
        }
    }
}
