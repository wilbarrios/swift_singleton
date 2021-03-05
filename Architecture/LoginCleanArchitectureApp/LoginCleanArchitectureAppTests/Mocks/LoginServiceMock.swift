//
//  LoginServiceMock.swift
//  LoginCleanArchitectureAppTests
//
//  Created by Wilmer Barrios on 04/03/21.
//

import Foundation
@testable import LoginCleanArchitectureApp

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
