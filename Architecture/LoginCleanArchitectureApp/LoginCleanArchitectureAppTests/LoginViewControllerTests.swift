//
//  LoginViewControllerTests.swift
//  LoginCleanArchitectureAppTests
//
//  Created by Wilmer Barrios on 03/03/21.
//

import Foundation
import UIKit
import XCTest
@testable import LoginCleanArchitectureApp

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

class LoginViewControllerTests: XCTestCase {
    func test_initializeWithNoMessages() {
        let sut = makeSUT()
        
        XCTAssertNil(sut.welcomeLabel.text, "Welcome message is displayed on initliazation")
        XCTAssertNil(sut.errorLabel.text, "Error message is displayed on initliazation")
    }
    
    func test_loginSucceed_displaysWelcomeMessage() {
        let sut = makeSUT()
        let welcomeMessage = makeAnySuccessMessage()
        sut.display(welcomeMessage: welcomeMessage)
        
        XCTAssertEqual(sut.welcomeLabel.text, welcomeMessage)
        XCTAssertNil(sut.errorLabel.text, "Error message is displayed on login succeed.")
    }
    
    func test_loginFailed_displaysErrorMessage() {
        let sut = makeSUT()
        let errorMessage = makeAnyError().localizedDescription
        sut.display(errorMessage: errorMessage)
        
        XCTAssertEqual(sut.errorLabel.text, errorMessage)
        XCTAssertNil(sut.welcomeLabel.text, "Welcome message is displayed on login succeed.")
    }
    
    func test_loginButton_triggersLoginUseCase() {
        let sut = makeSUT()
        loadController(sut)
        let exp = expectation(description: "Login use case action was no t triggered")
        
        let typedUserName = makeAnyUserName()
        let typedPassword = makeAnyPassword()
        
        var recivedUserName: String?
        var recivedPassword: String?
        sut.userName = typedUserName
        sut.password = typedPassword
        sut.login = { (userName, password) in
            recivedUserName = userName
            recivedPassword = password
            exp.fulfill()
        }
        
        simulateUserPushLoginButton(sut)
        wait(for: [exp], timeout: 0.1)
        XCTAssertEqual(recivedUserName, typedUserName)
        XCTAssertEqual(recivedPassword, typedPassword)
    }
    
    // MARK: Helpers
    private func makeAnyUserName() -> String {
        "anyUserName"
    }
    
    private func makeAnyPassword() -> String {
        "anyPassword"
    }
    
    private func makeAnySuccessMessage() -> String {
        "anySuccessMessage"
    }
    
    private func loadController(_ sut: LoginViewController) {
        sut.loadViewIfNeeded()
    }
    
    private func simulateUserPushLoginButton(_ sut: LoginViewController) {
        sut.loginButton.sendActions(for: .touchUpInside)
    }
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> LoginViewController {
        let c = LoginViewController()
        trackMemoryLeaks(c, file: file, line: line)
        return c
    }
    
}
