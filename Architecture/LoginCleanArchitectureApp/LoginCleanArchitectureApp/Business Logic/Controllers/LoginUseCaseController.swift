//
//  LoginUseCaseController.swift
//  LoginCleanArchitectureApp
//
//  Created by Wilmer Barrios on 03/03/21.
//

import Foundation

final class LoginUseCaseController: LoginUseCase {
    
    private let output: LoginUseCaseOutput
    private let loginService: LoginService
    
    init(output: LoginUseCaseOutput, loginService: LoginService) {
        self.output = output
        self.loginService = loginService
    }
    
    func login(username: String, password: String) {
        let user = map(userName: username)
        loginService.login(username: username, password: password) { [weak self] error in
            guard let _error = error else { self?.output.loginSuceeded(user: user); return }
            self?.output.loginFailed(error: _error)
        }
    }
    
    private func map(userName: String) -> User {
        return User(userName: userName)
    }
    
}
