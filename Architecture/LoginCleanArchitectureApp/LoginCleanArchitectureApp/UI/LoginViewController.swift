//
//  LoginViewController.swift
//  LoginCleanArchitectureApp
//
//  Created by Wilmer Barrios on 04/03/21.
//

import Foundation
import UIKit

final class LoginViewController: UIViewController, LoginView {
    // MARK: UI Components
    let errorLabel: UILabel = UILabel()
    let welcomeLabel: UILabel = UILabel()
    
    private let userNameTextField: UITextField = UITextField()
    private let passwordTextField: UITextField = UITextField()
    
    let loginButton: UIButton = {
        let b = UIButton()
        b.setTitle(LoginPresenter.R.login, for: .normal)
        b.addTarget(self, action: #selector(loginButtonHandler), for: .touchUpInside)
        return b
    }()
    
    // MARK: VC Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayout()
    }
    
    // MARK: Helpers
    private func setupLayout() {
        [errorLabel
         , welcomeLabel
         , userNameTextField
         , passwordTextField
         , loginButton
        ].forEach({ setupSubview($0) })
        
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: safeTopAnchor, constant: applicationPadding)
            , welcomeLabel.bottomAnchor.constraint(equalTo: safeBottomAnchor, constant: applicationPadding)
            , userNameTextField.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: applicationPadding)
            , passwordTextField.topAnchor.constraint(equalTo: view.centerYAnchor, constant: applicationPadding)
            , loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: applicationPadding)
        ])
    }
    
    private var safeTopAnchor: NSLayoutYAxisAnchor {
        view.safeAreaLayoutGuide.topAnchor
    }
    
    private var safeBottomAnchor: NSLayoutYAxisAnchor {
        view.safeAreaLayoutGuide.bottomAnchor
    }
    
    private var applicationPadding: CGFloat {
        15.0
    }
    
    private func fillWidth(_ subView: UIView, padding: CGFloat = 20.0) {
        subView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -padding).isActive = true
    }
    
    private func setupSubview(_ subView: UIView) {
        view.addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        fillWidth(subView)
    }
    
    // MARK: User interacion
    // Input values
    var userName: String? {
        get { userNameTextField.text }
        set { userNameTextField.text = newValue }
    }
    
    var password: String? {
        get { passwordTextField.text }
        set { passwordTextField.text = newValue }
    }
    
    // Handlers
    @objc
    private func loginButtonHandler() {
        // Simple text validation
        guard let _password = password, let _userName = userName else { return }
        login?(_userName, _password)
    }
    
    // MARK: Login use case
    var login: ((String, String) -> Void)?
    
    // MARK: Extension
    func display(welcomeMessage: String) {
        welcomeLabel.text = welcomeMessage
    }
    
    func display(errorMessage: String) {
        errorLabel.text = errorMessage
    }
}
