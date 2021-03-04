//
//  LoginUseCaseController.swift
//  LoginCleanArchitectureAppTests
//
//  Created by Wilmer Barrios on 03/03/21.
//

import Foundation
import XCTest
@testable import LoginCleanArchitectureApp

class LoginUseCaseControllerTests: XCTestCase {
    func test_initializationDoesNotTriggerAnyAction() {
        let (_, out, provider) = makeSUT()
        
        XCTAssertEqual(out.triggeredActions, [])
        XCTAssertEqual(provider.triggeredActions, [])
    }
    
    private func makeSUT() -> (sut: LoginUseCaseController, output: LoginUseCaseOutputMock, provider: LoginProviderMock) {
        let p = LoginProviderMock()
        let out = LoginUseCaseOutputMock()
        let sut = LoginUseCaseController(output: out, loginProvider: p)
        
        return (sut, out, p)
    }
    
    class LoginUseCaseOutputMock: LoginUseCaseOutput {
        enum Action: Equatable {
            
        }
        var triggeredActions = [Action]()
        
        func loginSuceeded(user: User) {
            
        }
        
        func loginFailed(error: Error) {
            
        }
    }
    
    class LoginProviderMock: LoginUseCase {
        
        
        enum Action: Equatable {
            
        }
        
        var triggeredActions = [Action]()
        
        func login(username: String, password: String, completion: @escaping (Error?) -> Void) {
            
        }
    }
}
