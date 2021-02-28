//
//  XCTestCase+Extensions.swift
//  SOLIDPrinciplesTests
//
//  Created by Wilmer Barrios on 28/02/21.
//

import Foundation
import XCTest

extension XCTestCase {
    func trackMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock {
            [weak instance] in
            XCTAssertNil(instance, "Instance was not deallocated, potential memory leak", file: file, line: line)
        }
    }
}
