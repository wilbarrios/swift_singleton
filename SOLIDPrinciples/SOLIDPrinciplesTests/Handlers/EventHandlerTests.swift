//
//  EventHandlerTests.swift
//  SOLIDPrinciplesTests
//
//  Created by Wilmer Barrios on 28/02/21.
//

import Foundation
import XCTest
@testable import SOLIDPrinciples

protocol Event { }

class EventHandler {
    var lastSentEvent: Event?
}

class EventHandlerTests: XCTestCase {
    func test_initializationDoesNotSentEvents() {
        let sut = EventHandler()
        
        XCTAssertNil(sut.lastSentEvent, "Event was sent on initialization.")
    }
}
