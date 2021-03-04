//
//  LoginUseCase.swift
//  LoginCleanArchitectureApp
//
//  Created by Wilmer Barrios on 03/03/21.
//

import Foundation

protocol LoginUseCase {
    func login(username: String, password: String)
}

protocol LoginService {
    func login(username: String, password: String, completion: @escaping (Error?) -> Void)
}

struct User {
    let userName: String
}

protocol LoginUseCaseOutput {
    func loginSuceeded(user: User)
    func loginFailed(error: Error)
}

final class LoginUseCaseController: LoginUseCase {
    
    private let output: LoginUseCaseOutput
    private let loginService: LoginService
    
    init(output: LoginUseCaseOutput, loginService: LoginService) {
        self.output = output
        self.loginService = loginService
    }
    
    func login(username: String, password: String) {
        let user = map(userName: username)
        loginService.login(username: username, password: password) { [weak self] _ in
            self?.output.loginSuceeded(user: user)
        }
    }
    
    private func map(userName: String) -> User {
        return User(userName: userName)
    }
    
}
