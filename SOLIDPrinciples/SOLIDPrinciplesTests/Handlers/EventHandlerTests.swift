//
//  EventHandlerTests.swift
//  SOLIDPrinciplesTests
//
//  Created by Wilmer Barrios on 28/02/21.
//

import Foundation
import XCTest
@testable import SOLIDPrinciples

class EventHandlerTests: XCTestCase {
    
    func test_initializationDoesNotSentEvents() {
        let (sut, service) = makeSUT()
        
        XCTAssertNil(sut.lastSentEvent, "Event was sent on initialization.")
        XCTAssertEqual(service.triggeredActions, [])
    }
    
    func test_sendEventTriggersEventNotificationOnEventService() {
        let (sut, service) = makeSUT()
        
        sut.sendEvent(makeAnyEvent())
        
        XCTAssertEqual(service.triggeredActions, [.send])
    }
    
    func test_retreivesErrorOnServiceError() {
        let (sut, service) = makeSUT()
        let exp = expectation(description: "Send event service was not completed.")
        
        let error = makeAnyError()
        var retrivedError: Error?
        sut.sendEvent(makeAnyEvent()) { (error) in
            retrivedError = error
            exp.fulfill()
        }
        service.complete(withError: error)
        
        wait(for: [exp], timeout: 0.1)
        XCTAssertNotNil(retrivedError, "An error was not retrived on Event notification service error.")
        XCTAssertEqual(error, retrivedError! as NSError)
    }
    
    // MARK: Helpers
    private func makeAnyEvent() -> Event {
        EventStub.anyEvent
    }
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: EventHandler, service: EventServiceMock) {
        let service = EventServiceMock()
        let sut = EventHandler(service: service)
        trackMemoryLeaks(service, file: file, line: line)
        trackMemoryLeaks(sut, file: file, line: line)
        return (sut, service)
    }
}

fileprivate enum EventStub: String {
    case anyEvent
}

extension EventStub: Event {
    var eventId: String { return "event.\(self.rawValue)" }
}
