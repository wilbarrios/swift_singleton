//
//  LoginUseCaseOutputMock.swift
//  LoginCleanArchitectureAppTests
//
//  Created by Wilmer Barrios on 03/03/21.
//

import Foundation
@testable import LoginCleanArchitectureApp

class LoginUseCaseOutputMock: LoginUseCaseOutput {
    enum Action: Equatable {
        case loginSuceeded
        , loginFailed
    }
    var triggeredActions = [Action]()
    
    func loginSuceeded(user: User) {
        triggeredActions.append(.loginSuceeded)
    }
    
    func loginFailed(error: Error) {
        triggeredActions.append(.loginFailed)
    }
}
