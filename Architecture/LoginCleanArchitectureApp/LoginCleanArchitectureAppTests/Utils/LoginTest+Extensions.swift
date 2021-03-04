//
//  LoginTest+Extensions.swift
//  LoginCleanArchitectureAppTests
//
//  Created by Wilmer Barrios on 03/03/21.
//

import Foundation
import XCTest
@testable import LoginCleanArchitectureApp

protocol LoginTest: XCTestCase {}

extension LoginTest {
    func makeAnyUser() -> User {
        User(userName: makeAnyUserName())
    }
    
    func makeAnyUserName() -> String {
        return "anyUserName"
    }
    
    func makeAnyPassword() -> String {
        return "anyPassword"
    }
}
