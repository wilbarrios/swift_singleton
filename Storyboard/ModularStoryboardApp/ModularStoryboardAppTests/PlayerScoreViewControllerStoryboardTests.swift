//
//  PlayerScoreViewControllerStoryboardTests.swift
//  ModularStoryboardAppTests
//
//  Created by Wilmer Barrios on 07/03/21.
//

import Foundation
import XCTest
@testable import ModularStoryboardApp

class PlayerScoreViewControllerStoryboardTests: XCTestCase {
    func test_playerOneStoryboardInitialViewController_isPlayerScoreViewController() {
        let storyboard = UIStoryboard(name: "PlayerScoreView", bundle: nil)
        
        XCTAssertTrue(storyboard.instantiateInitialViewController() is PlayerScoreViewController)
    }
}
