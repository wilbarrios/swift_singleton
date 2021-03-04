//
//  LoginUseCase.swift
//  LoginCleanArchitectureApp
//
//  Created by Wilmer Barrios on 03/03/21.
//

import Foundation

struct User {
    let userName: String
}

protocol LoginUseCase {
    func login(username: String, password: String)
}

protocol LoginUseCaseOutput {
    func loginSuceeded(user: User)
    func loginFailed(error: Error)
}
