//
//  SingleResponsibilityControllerTests.swift
//  SOLIDPrinciplesTests
//
//  Created by Wilmer Barrios on 28/02/21.
//

import Foundation
import XCTest
@testable import SOLIDPrinciples

class SingleResponsibilityControllerTests: XCTestCase {
    func test_initializationDoesNotSave() {
        let (_, handler) = makeSUT()
        XCTAssertEqual(handler.triggeredActions, [], "Save was triggered on initialization.")
    }
    
    func test_controllerLoadDoesNotSave() {
        let (sut, handler) = makeSUT()
        loadSUT(sut)
        XCTAssertEqual(handler.triggeredActions, [], "Save was triggered on load.")
    }
    
    // MARK: Helpers
    private func loadSUT(_ sut: SingleResponsibilityController) {
        sut.loadViewIfNeeded()
    }
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: SingleResponsibilityController, handler: SaveHandlerMock) {
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
    
    func trackMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock {
            [weak instance] in
            XCTAssertNil(instance, "Instance was not deallocated, potential memory leak", file: file, line: line)
        }
    }
}
