//
//  LoginPresenter.swift
//  LoginCleanArchitectureApp
//
//  Created by Wilmer Barrios on 03/03/21.
//

import Foundation

protocol LoginView {
    func display(welcomeMessage: String)
    func display(errorMessage: String)
}

final class LoginPresenter: LoginUseCaseOutput {
    let view: LoginView
    
    struct R {
        static let welcome = "Welcome"
        static let errorMessage = "Login failed! Try again later."
    }
    
    init(view: LoginView) {
        self.view = view
    }
    
    // MARK: Extension

    func loginSuceeded(user: User) {
        view.display(welcomeMessage: makeWelcomeMessage(userName: user.toString))
    }
    
    func loginFailed(error: Error) {
        view.display(errorMessage: R.errorMessage)
    }
    
    // MARK: Helpers
    private func makeWelcomeMessage(userName: String) -> String {
        return "\(R.welcome) \(userName)!"
    }
}
