//
//  EventHandlerTests.swift
//  SOLIDPrinciplesTests
//
//  Created by Wilmer Barrios on 28/02/21.
//

import Foundation
import XCTest
@testable import SOLIDPrinciples

protocol Event { var eventId: String { get } }

protocol EventService {
    func send(event: String, completion: @escaping (Error?) -> Void)
}

class EventHandler {
    var lastSentEvent: Event?
    
    let service: EventService
    
    init(service: EventService) {
        self.service = service
    }
    
    func sendEvent(_ event: Event, completion: @escaping (Error?) -> Void = {_ in }) {
        lastSentEvent = event
        service.send(event: event.eventId, completion: completion)
    }
}

class EventHandlerTests: XCTestCase {
    
    func test_initializationDoesNotSentEvents() {
        let (sut, service) = makeSUT()
        
        XCTAssertNil(sut.lastSentEvent, "Event was sent on initialization.")
        XCTAssertEqual(service.triggeredActions, [])
    }
    
    func test_sendEventTriggersEventNotificationOnEventService() {
        let (sut, service) = makeSUT()
        
        sut.sendEvent(EventStub.anyEvent)
        
        XCTAssertEqual(service.triggeredActions, [.send])
    }
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: EventHandler, service: EventServiceMock) {
        let service = EventServiceMock()
        let sut = EventHandler(service: service)
        trackMemoryLeaks(service, file: file, line: line)
        trackMemoryLeaks(sut, file: file, line: line)
        return (sut, service)
    }
    
    class EventServiceMock: EventService {
        enum Action {
            case send
        }
        
        var triggeredActions = [Action]()
        
        func send(event: String, completion: @escaping (Error?) -> Void) {
            triggeredActions.append(.send)
        }
    }
}

fileprivate enum EventStub: String {
    case anyEvent
}

extension EventStub: Event {
    var eventId: String { return "event.\(self.rawValue)" }
}
