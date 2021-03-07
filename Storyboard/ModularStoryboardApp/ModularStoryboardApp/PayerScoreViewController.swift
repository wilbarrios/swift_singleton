//
//  PayerScoreViewController.swift
//  ModularStoryboardApp
//
//  Created by Wilmer Barrios on 07/03/21.
//

import Foundation
import UIKit

final class PlayerScoreViewController: UIViewController {
    @IBOutlet weak var playerNameLabel: UILabel!
    
    var playerName: String? { get { playerNameLabel.text } set { playerNameLabel.text = newValue }}
}
