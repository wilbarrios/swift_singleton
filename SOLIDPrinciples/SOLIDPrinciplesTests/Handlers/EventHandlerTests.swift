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
    private func makeAnyError() -> NSError {
        return NSError(domain: "Any error", code: 0, userInfo: nil)
    }
    
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
    
    class EventServiceMock: EventService {
        typealias EventCompletionHandler = ((Error?) -> Void)
        
        enum Action {
            case send
        }
        
        var triggeredActions = [Action]()
        private var completions = [EventCompletionHandler]()
        
        
        func send(event: String, completion: @escaping EventCompletionHandler) {
            triggeredActions.append(.send)
            completions.append(completion)
        }
        
        func complete(withError error: Error?, index: Int = 0) {
            completions[index](error)
        }
    }
}

fileprivate enum EventStub: String {
    case anyEvent
}

extension EventStub: Event {
    var eventId: String { return "event.\(self.rawValue)" }
}
