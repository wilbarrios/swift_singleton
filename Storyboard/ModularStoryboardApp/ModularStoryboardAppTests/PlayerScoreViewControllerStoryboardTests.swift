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
    
    func test_playerOneView_userNameIsSettable() {
        let sut = makeSUT()
        
        sut.playerName = makeAnyPlayerName()
        
        XCTAssertEqual(sut.playerNameLabel.text, makeAnyPlayerName())
    }
    
    private func makeAnyPlayerName() -> String {
        "AnyPlayerName"
    }
    
    private func makeSUT() -> PlayerScoreViewController {
        let storyboard = UIStoryboard(name: "PlayerScoreView", bundle: nil)
        let vc = storyboard.instantiateInitialViewController()
        vc?.loadViewIfNeeded()
        return vc as! PlayerScoreViewController
    }
}
