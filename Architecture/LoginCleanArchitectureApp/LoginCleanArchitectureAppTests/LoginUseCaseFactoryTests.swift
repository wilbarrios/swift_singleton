//
//  LoginUseCaseFactoryTests.swift
//  LoginCleanArchitectureAppTests
//
//  Created by Wilmer Barrios on 04/03/21.
//

import Foundation
import XCTest
@testable import LoginCleanArchitectureApp

final class LoginUseCaseFactory {
    let service: LoginService
    private var controller: LoginUseCaseController?
    
    init(service: LoginService) {
        self.service = service
    }
    
    func makeViewController() -> UIViewController {
        let viewController = LoginViewController()
        let presenter = LoginPresenter(view: viewController)
        let controller = LoginUseCaseController(output: presenter, loginService: service)
        self.controller = controller
        return viewController
    }
}

class LoginUseCaseFactoryTests: XCTestCase {
    func test_init() {
        let (sut, _) = makeSUT()
        
        XCTAssert(sut.makeViewController() is LoginViewController)
    }
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: LoginUseCaseFactory, service: LoginServiceMock) {
        let service = LoginServiceMock()
        let sut = LoginUseCaseFactory(service: service)
        trackMemoryLeaks(service, file: file, line: line)
        trackMemoryLeaks(sut, file: file, line: line)
        return (sut, service)
    }
}
