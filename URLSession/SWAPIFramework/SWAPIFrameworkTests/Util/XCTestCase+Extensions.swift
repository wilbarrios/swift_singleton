//
//  XCTestCase+Extensions.swift
//  SWAPIFrameworkTests
//
//  Created by Wilmer Barrios on 11/03/21.
//

import Foundation
import XCTest

extension XCTestCase {
    func trackMemoryLeaks(_ object: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock {
            [weak object] in
            XCTAssertNil(object, "Instance was not deallocated, potential memory leak.", file: file, line: line)
        }
    }
}
