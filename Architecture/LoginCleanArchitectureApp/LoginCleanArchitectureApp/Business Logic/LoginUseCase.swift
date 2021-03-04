//
//  LoginUseCase.swift
//  LoginCleanArchitectureApp
//
//  Created by Wilmer Barrios on 03/03/21.
//

import Foundation

protocol LoginUseCase {
    func login(username: String, password: String, completion: @escaping (Error?) -> Void)
}

struct User {}

protocol LoginUseCaseOutput {
    func loginSuceeded(user: User)
    func loginFailed(error: Error)
}

final class LoginUseCaseController: LoginUseCase {
    
    private let output: LoginUseCaseOutput
    private let loginProvider: LoginUseCase
    
    init(output: LoginUseCaseOutput, loginProvider: LoginUseCase) {
        self.output = output
        self.loginProvider = loginProvider
    }
    
    func login(username: String, password: String, completion: @escaping (Error?) -> Void) {
        loginProvider.login(username: username, password: password, completion: completion)
    }
    
}
