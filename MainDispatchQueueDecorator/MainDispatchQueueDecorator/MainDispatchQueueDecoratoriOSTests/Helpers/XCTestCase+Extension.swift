//
//  XCTestCase+Extension.swift
//  MainDispatchQueueDecoratoriOSTests
//
//  Created by Wilmer Barrios on 06/05/21.
//

import Foundation
import XCTest

extension XCTestCase {
    func trackMemoryLeaks(_ object: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock {
            [weak object] in
            XCTAssertNil(object, "Instance should be deallocated, potential memory leak", file: file, line: line)
        }
    }
}
