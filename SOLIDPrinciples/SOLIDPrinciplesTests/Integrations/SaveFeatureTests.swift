//
//  SaveFeatureTests.swift
//  SOLIDPrinciplesTests
//
//  Created by Wilmer Barrios on 28/02/21.
//

import Foundation
import XCTest
@testable import SOLIDPrinciples

class SaveFeatureTests: XCTestCase, SingleResponibilityTest {
    
    func test_controllerInitializationDoesNotSave() {
        let (_, saveHandler, eventService) = makeSUT()
        XCTAssertEqual(saveHandler.triggeredActions, [])
        XCTAssertEqual(eventService.triggeredActions, [])
    }
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: SingleResponsibilityController, handler: SaveHandlerMock, eventService: EventServiceMock) {
        let eventService = EventServiceMock()
        let saveMock = SaveHandlerMock()
        let decorator = SaveDecorator(decorated: saveMock, eventService: eventService)
        let controller = SingleResponsibilityController(saveHandler: decorator)
        trackMemoryLeaks(eventService, file: file, line: line)
        trackMemoryLeaks(saveMock, file: file, line: line)
        trackMemoryLeaks(decorator, file: file, line: line)
        trackMemoryLeaks(controller, file: file, line: line)
        return (controller, saveMock, eventService)
    }
}

