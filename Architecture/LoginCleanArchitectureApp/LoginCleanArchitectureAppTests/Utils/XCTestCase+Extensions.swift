//
//  XCTestCase+Extensions.swift
//  LoginCleanArchitectureAppTests
//
//  Created by Wilmer Barrios on 03/03/21.
//

import Foundation
import XCTest

extension XCTestCase {
    func trackMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock {
            [weak instance] in
            XCTAssertNil(instance, "Instance was not dealocated, potential memory leak.", file: file, line: line)
        }
    }
    
    func makeAnyError() -> NSError {
        NSError(domain: "anyDomain", code: 0, userInfo: nil)
    }
}
