//
//  LoginViewControllerTests.swift
//  LoginCleanArchitectureAppTests
//
//  Created by Wilmer Barrios on 03/03/21.
//

import Foundation
import XCTest
@testable import LoginCleanArchitectureApp

class LoginViewControllerTests: XCTestCase {
    func test_initializeWithNoMessages() {
        let sut = makeSUT()
        
        XCTAssertNil(sut.welcomeLabel.text, "Welcome message is displayed on initliazation")
        XCTAssertNil(sut.errorLabel.text, "Error message is displayed on initliazation")
    }
    
    func test_loginSucceed_displaysWelcomeMessage() {
        let sut = makeSUT()
        let welcomeMessage = makeAnySuccessMessage()
        sut.display(welcomeMessage: welcomeMessage)
        
        XCTAssertEqual(sut.welcomeLabel.text, welcomeMessage)
        XCTAssertNil(sut.errorLabel.text, "Error message is displayed on login succeed.")
    }
    
    func test_loginFailed_displaysErrorMessage() {
        let sut = makeSUT()
        let errorMessage = makeAnyError().localizedDescription
        sut.display(errorMessage: errorMessage)
        
        XCTAssertEqual(sut.errorLabel.text, errorMessage)
        XCTAssertNil(sut.welcomeLabel.text, "Welcome message is displayed on login succeed.")
    }
    
    func test_loginButton_triggersLoginUseCase() {
        let sut = makeSUT()
        loadController(sut)
        let exp = expectation(description: "Login use case action was no t triggered")
        
        let typedUserName = makeAnyUserName()
        let typedPassword = makeAnyPassword()
        
        var recivedUserName: String?
        var recivedPassword: String?
        sut.userName = typedUserName
        sut.password = typedPassword
        sut.login = { (userName, password) in
            recivedUserName = userName
            recivedPassword = password
            exp.fulfill()
        }
        
        simulateUserPushLoginButton(sut)
        wait(for: [exp], timeout: 0.1)
        XCTAssertEqual(recivedUserName, typedUserName)
        XCTAssertEqual(recivedPassword, typedPassword)
    }
    
    // MARK: Helpers
    private func makeAnyUserName() -> String {
        "anyUserName"
    }
    
    private func makeAnyPassword() -> String {
        "anyPassword"
    }
    
    private func makeAnySuccessMessage() -> String {
        "anySuccessMessage"
    }
    
    private func loadController(_ sut: LoginViewController) {
        sut.loadViewIfNeeded()
    }
    
    private func simulateUserPushLoginButton(_ sut: LoginViewController) {
        sut.loginButton.sendActions(for: .touchUpInside)
    }
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> LoginViewController {
        let c = LoginViewController()
        trackMemoryLeaks(c, file: file, line: line)
        return c
    }
    
}
