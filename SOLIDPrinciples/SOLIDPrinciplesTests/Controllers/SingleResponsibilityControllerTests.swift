//
//  SingleResponsibilityControllerTests.swift
//  SOLIDPrinciplesTests
//
//  Created by Wilmer Barrios on 28/02/21.
//

import Foundation
import XCTest
@testable import SOLIDPrinciples

class SingleResponsibilityControllerTests: XCTestCase, SingleResponibilityTest {
    private typealias SUT = SingleResponsibilityController
    
    func test_initializationDoesNotSave() {
        let (_, handler) = makeSUT()
        XCTAssertEqual(handler.triggeredActions, [], "Save was triggered on initialization.")
    }
    
    func test_controllerLoadDoesNotSave() {
        let (sut, handler) = makeSUT()
        loadController(sut)
        XCTAssertEqual(handler.triggeredActions, [], "Save was triggered on load.")
    }
    
    func test_saveOnUserTapSaveButton() {
        let (sut, handler) = makeSUT()

        loadController(sut)
        simulateUserDidTapOnSaveButton(sut)
        
        XCTAssertEqual(handler.triggeredActions, [.save], "Save was triggered on load.")
    }
    
    // MARK: Helpers
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: SUT, handler: SaveHandlerMock) {
        let saveHandlerMock = SaveHandlerMock()
        let sut = SingleResponsibilityController(saveHandler: saveHandlerMock)
        trackMemoryLeaks(saveHandlerMock, file: file, line: line)
        trackMemoryLeaks(sut, file: file, line: line)
        return (sut, saveHandlerMock)
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
