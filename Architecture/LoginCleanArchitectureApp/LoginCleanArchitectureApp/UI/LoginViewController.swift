//
//  LoginViewController.swift
//  LoginCleanArchitectureApp
//
//  Created by Wilmer Barrios on 04/03/21.
//

import Foundation
import UIKit

final class LoginViewController: UIViewController, LoginView {
    private typealias R = LoginPresenter.R
    // MARK: UI Components
    let errorLabel: UILabel = UILabel()
    let welcomeLabel: UILabel = UILabel()
    
    private let userNameTextField: UITextField = {
        let t = UITextField()
        t.placeholder = R.userName
        return t
    }()
    
    private let passwordTextField: UITextField = {
        let t = UITextField()
        t.placeholder = R.password
        return t
    }()
    
    let loginButton: UIButton = {
        let b = UIButton()
        b.setTitle(R.login, for: .normal)
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
        self.view.backgroundColor = UIColor.systemGray2
        
        [errorLabel
         , welcomeLabel
         , userNameTextField
         , passwordTextField
         , loginButton
        ].forEach({ setupSubview($0) })
        
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: safeTopAnchor, constant: applicationPadding)
            , welcomeLabel.bottomAnchor.constraint(equalTo: safeBottomAnchor, constant: -applicationPadding)
            , userNameTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -applicationPadding)
            , passwordTextField.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -applicationPadding)
            , loginButton.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: applicationPadding)
        ])
        
        passwordTextField.delegate = self
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
        subView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        subView.backgroundColor = UIColor.orange
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
        view.endEditing(true)
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

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginButtonHandler()
        return true
    }
}
