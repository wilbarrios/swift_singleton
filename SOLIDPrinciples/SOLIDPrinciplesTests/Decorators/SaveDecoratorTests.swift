//
//  SaveDecoratorTests.swift
//  SOLIDPrinciplesTests
//
//  Created by Wilmer Barrios on 28/02/21.
//

import Foundation
import XCTest
@testable import SOLIDPrinciples

/// `SingleReponsibility` controller events
enum SEvent: String {
    case save
}

extension SEvent: Event {
    var eventId: String {
        return "event.\(self.rawValue)"
    }
}

class SaveDecorator<T: SaveHandler>: SaveHandler {
    private let decorated: T
    private let eventService: EventService
    
    lazy var eventHandler: EventHandler = {
        return EventHandler(service: eventService)
    }()
    
    init(decorated: T, eventService: EventService) {
        self.decorated = decorated
        self.eventService = eventService
    }
    
    func save(completion: @escaping SaveCompletionHandler) {
        decorated.save(completion: { [weak self] error in
            guard error == nil else { return }
            self?.eventHandler.sendEvent(SEvent.save)
        })
    }
}

class SaveDecoratorTests: XCTestCase {
    func test_initializationDoesNotTriggerEventNotificationServiceAndDoesNotDeliverMessageToDecorated() {
        let (_, decorated, service) = makeSUT()
        
        XCTAssertEqual(decorated.triggeredActions, [])
        XCTAssertEqual(service.triggeredActions, [])
    }
    
    func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: SaveDecorator<SaveHandlerMock>, decorated: SaveHandlerMock, eventService: EventServiceMock) {
        let service = EventServiceMock()
        let decoratedMock = SaveHandlerMock()
        let sut = SaveDecorator(decorated: decoratedMock, eventService: service)
        trackMemoryLeaks(service, file: file, line: line)
        trackMemoryLeaks(decoratedMock, file: file, line: line)
        trackMemoryLeaks(sut, file: file, line: line)
        return (sut, decoratedMock, service)
    }
    
    class SaveHandlerMock: SaveHandler {
        enum Action {
            case save
        }
        
        var triggeredActions = [Action]()
        
        func save(completion: @escaping SaveCompletionHandler) {
            triggeredActions.append(.save)
        }
    }
}
