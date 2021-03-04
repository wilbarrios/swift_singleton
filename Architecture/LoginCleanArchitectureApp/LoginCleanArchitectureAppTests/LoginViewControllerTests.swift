//
//  LoginViewControllerTests.swift
//  LoginCleanArchitectureAppTests
//
//  Created by Wilmer Barrios on 03/03/21.
//

import Foundation
import UIKit
import XCTest
@testable import LoginCleanArchitectureApp

final class LoginViewController: UIViewController, LoginView {
    let errorLabel: UILabel = UILabel()
    let welcomeLabel: UILabel = UILabel()
    
    // MARK: Extension
    func display(welcomeMessage: String) {
        welcomeLabel.text = welcomeMessage
    }
    
    func display(errorMessage: String) {
        errorLabel.text = errorMessage
    }
}

class LoginViewControllerTests: XCTestCase {
    func test_initializeWithNoMessages() {
        let sut = makeSUT()
        
        XCTAssertNil(sut.welcomeLabel.text, "Welcome message is displayed on initliazation")
        XCTAssertNil(sut.errorLabel.text, "Error message is displayed on initliazation")
    }
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> LoginViewController {
        let c = LoginViewController()
        trackMemoryLeaks(c, file: file, line: line)
        return c
    }
    
}
