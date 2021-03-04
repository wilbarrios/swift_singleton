//
//  LoginPresenterTests.swift
//  LoginCleanArchitectureAppTests
//
//  Created by Wilmer Barrios on 03/03/21.
//

import Foundation
import XCTest
@testable import LoginCleanArchitectureApp

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
    
    func test_loginFailed_deliversErrorMessage() {
        let (sut, view) = makeSUT()
        
        sut.loginFailed(error: makeAnyError())
        
        XCTAssertEqual(view.triggeredActions, [.displayErrorMessage])
        XCTAssertEqual(view.displayedErrorMessage, makeExpectedErrorMessage())
    }
    
    // MARK: Helpers
    private func makeExpectedErrorMessage() -> String {
        LoginPresenter.R.errorMessage
    }
    
    private func makeExpectedWelcomeMessage(userName: String) -> String {
        "\(LoginPresenter.R.welcome) \(userName)!"
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
