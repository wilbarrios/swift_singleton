//
//  SaveDecoratorTests.swift
//  SOLIDPrinciplesTests
//
//  Created by Wilmer Barrios on 28/02/21.
//

import Foundation
import XCTest
@testable import SOLIDPrinciples

class SaveDecoratorTests: XCTestCase {
    func test_initializationDoesNotTriggerEventNotificationServiceAndDoesNotDeliverMessageToDecorated() {
        let (_, decorated, service) = makeSUT()
        
        XCTAssertEqual(decorated.triggeredActions, [])
        XCTAssertEqual(service.triggeredActions, [])
    }
    
    func test_decoratedSaveSuccessSendEventNotification() {
        let (sut, decorated, service) = makeSUT()
        
        sut.save {_ in }
        decorated.complete(withError: nil)
        
        XCTAssertEqual(decorated.triggeredActions, [.save])
        XCTAssertEqual(service.triggeredActions, [.send])
    }
    
    func test_decoratedSaveFailureDoesNotSendEventNotification() {
        let (sut, decorated, service) = makeSUT()
        
        sut.save {_ in }
        decorated.complete(withError: makeAnyError())
        
        XCTAssertEqual(decorated.triggeredActions, [.save])
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
        
        private typealias CompletionHandler = ((Error?) -> Void)
        
        var triggeredActions = [Action]()
        private var completions = [CompletionHandler]()
        
        func save(completion: @escaping SaveCompletionHandler) {
            triggeredActions.append(.save)
            completions.append(completion)
        }
        
        func complete(withError error: Error?, index: Int = 0) {
            completions[0](error)
        }
    }
}
