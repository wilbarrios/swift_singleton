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

class LoginPresenter {
    let output: LoginUseCaseOutput
    let view: LoginView
    
    init(output: LoginUseCaseOutput, view: LoginView) {
        self.output = output
        self.view = view
    }
}

class LoginPresenterTests: XCTestCase {
    func test_initializationDoesnotPresentsMessages() {
        let (_, _, view) = makeSUT()
        
        XCTAssertEqual(view.triggeredActions, [])
    }
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: LoginPresenter, output: LoginUseCaseOutputMock, view: ViewMock) {
        let v = ViewMock()
        let out = LoginUseCaseOutputMock()
        let sut = LoginPresenter(output: out, view: v)
        trackMemoryLeaks(v, file: file, line: line)
        trackMemoryLeaks(out, file: file, line: line)
        trackMemoryLeaks(sut, file: file, line: line)
        return (sut, out, v)
    }
    
    class ViewMock: LoginView {
        enum Action {
            case displayErrorMessage,
                 displayWelcomeMessage
        }
        
        var triggeredActions = [Action]()
        
        func display(errorMessage: String) {
            triggeredActions.append(.displayErrorMessage)
        }
        
        func display(welcomeMessage: String) {
            triggeredActions.append(.displayWelcomeMessage)
        }
    }
    
}
