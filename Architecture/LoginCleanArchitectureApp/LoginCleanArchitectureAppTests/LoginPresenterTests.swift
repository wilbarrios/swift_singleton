//
//  LoginPresenterTests.swift
//  LoginCleanArchitectureAppTests
//
//  Created by Wilmer Barrios on 03/03/21.
//

import Foundation
import XCTest
@testable import LoginCleanArchitectureApp

protocol LoginView {
    func display(welcomeMessage: String)
    func display(errorMessage: String)
}

class LoginPresenter: LoginUseCaseOutput {
    let view: LoginView
    
    struct R {
        static let welcomeMessage = "Welcome"
    }
    
    init(view: LoginView) {
        self.view = view
    }
    
    // MARK: Extension

    func loginSuceeded(user: User) {
        view.display(welcomeMessage: makeWelcomeMessage(userName: map(user)))
    }
    
    func loginFailed(error: Error) {
        
    }
    
    // MARK: Helpers
    private func map(_ user: User) -> String {
        user.userName
    }
    
    private func makeWelcomeMessage(userName: String) -> String {
        return "\(R.welcomeMessage) \(userName)!"
    }
}

class LoginPresenterTests: XCTestCase, LoginTest {
    func test_initializationDoesnotPresentsMessages() {
        let (_, view) = makeSUT()
        
        XCTAssertEqual(view.triggeredActions, [])
    }
    
    func test_loginSucceed_deliversSucceedMessage() {
        let (sut, view) = makeSUT()
        
        let user = makeAnyUser()
        sut.loginSuceeded(user: user)
        
        XCTAssertEqual(view.triggeredActions, [.displayWelcomeMessage])
        XCTAssertEqual(view.displayedSucceedMessage, makeExpectedWelcomeMessage(userName: user.userName))
    }
    
    // MARK: Helpers
    private func makeExpectedWelcomeMessage(userName: String) -> String {
        "\(LoginPresenter.R.welcomeMessage) \(userName)!"
    }
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: LoginPresenter, view: ViewMock) {
        let v = ViewMock()
        let sut = LoginPresenter(view: v)
        trackMemoryLeaks(v, file: file, line: line)
        trackMemoryLeaks(sut, file: file, line: line)
        return (sut, v)
    }
    
    // MARK: Testing entities
    
    class ViewMock: LoginView {
        enum Action {
            case displayErrorMessage,
                 displayWelcomeMessage
        }
        
        var triggeredActions = [Action]()
        var displayedSucceedMessage: String?
        var displayedErrorMessage: String?
        
        func display(errorMessage: String) {
            triggeredActions.append(.displayErrorMessage)
            displayedErrorMessage = errorMessage
        }
        
        func display(welcomeMessage: String) {
            triggeredActions.append(.displayWelcomeMessage)
            displayedSucceedMessage = welcomeMessage
        }
    }
    
}
