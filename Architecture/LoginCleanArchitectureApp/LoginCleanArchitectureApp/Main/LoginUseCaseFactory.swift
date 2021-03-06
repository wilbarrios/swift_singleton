//
//  LoginUseCaseFactory.swift
//  LoginCleanArchitectureApp
//
//  Created by Wilmer Barrios on 04/03/21.
//

import Foundation
import UIKit

class WeakRef<T: AnyObject> {
    private weak var instance: T?
    init (_ instance: T) {
        self.instance = instance
    }
}

extension WeakRef: LoginView where T: LoginView {
    func display(welcomeMessage: String) {
        instance?.display(welcomeMessage: welcomeMessage)
    }
    
    func display(errorMessage: String) {
        instance?.display(errorMessage: errorMessage)
    }
}

final class LoginUseCaseFactory {
    func makeViewController(service: LoginService) -> UIViewController {
        let viewController = LoginViewController()
        let presenter = LoginPresenter(view: WeakRef(viewController))
        let controller = LoginUseCaseController(output: presenter, loginService: service)
        viewController.login = controller.login
        return viewController
    }
}
