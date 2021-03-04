//
//  LoginUseCaseController.swift
//  LoginCleanArchitectureAppTests
//
//  Created by Wilmer Barrios on 03/03/21.
//

import Foundation
import XCTest
@testable import LoginCleanArchitectureApp

class LoginUseCaseControllerTests: XCTestCase, LoginTest {
    func test_initializationDoesNotTriggerAnyAction() {
        let (_, out, provider) = makeSUT()
        
        XCTAssertEqual(out.triggeredActions, [])
        XCTAssertEqual(provider.triggeredActions, [])
    }
    
    func test_loginSucceed_deliversLoginSucces() {
        let (sut, out, provider) = makeSUT()
        
        sut.login(username: makeAnyUserName(), password: makeAnyPassword())
        provider.complete(nil)
        
        XCTAssertEqual(provider.triggeredActions, [.login])
        XCTAssertEqual(out.triggeredActions, [.loginSuceeded])
    }
    
    func test_loginFailed_deliversLoginFailure() {
        let (sut, out, provider) = makeSUT()
        
        sut.login(username: makeAnyUserName(), password: makeAnyPassword())
        provider.complete(makeAnyError())
        
        XCTAssertEqual(out.triggeredActions, [.loginFailed])
    }
    
    // MARK: Helpers
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: LoginUseCaseController, output: LoginUseCaseOutputMock, service: LoginServiceMock) {
        let p = LoginServiceMock()
        let out = LoginUseCaseOutputMock()
        let sut = LoginUseCaseController(output: out, loginService: p)
        trackMemoryLeaks(p, file: file, line: line)
        trackMemoryLeaks(out, file: file, line: line)
        trackMemoryLeaks(sut, file: file, line: line)
        return (sut, out, p)
    }
    
    // MARK: Testing entities
    
    class LoginServiceMock: LoginService {
        
        typealias LoginResult = Error?
        private typealias LoginCompletionHandler = (LoginResult) -> Void
        
        enum Action: Equatable {
            case login
        }
        
        var triggeredActions = [Action]()
        private var completions = [LoginCompletionHandler]()
        
        func login(username: String, password: String, completion: @escaping (Error?) -> Void) {
            triggeredActions.append(.login)
            completions.append(completion)
        }
        
        func complete(_ result: LoginResult, index: Int = 0) {
            completions[index](result)
        }
    }
}
