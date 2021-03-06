//
//  LoginUseCaseFactoryTests.swift
//  LoginCleanArchitectureAppTests
//
//  Created by Wilmer Barrios on 04/03/21.
//

import Foundation
import XCTest
@testable import LoginCleanArchitectureApp

class LoginUseCaseFactoryTests: XCTestCase {
    func test_init() {
        let (sut, service) = makeSUT()
        
        XCTAssert(sut.makeViewController(service: service) is LoginViewController)
    }
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: LoginUseCaseFactory, service: LoginServiceMock) {
        let service = LoginServiceMock()
        let sut = LoginUseCaseFactory()
        trackMemoryLeaks(service, file: file, line: line)
        trackMemoryLeaks(sut, file: file, line: line)
        return (sut, service)
    }
}
