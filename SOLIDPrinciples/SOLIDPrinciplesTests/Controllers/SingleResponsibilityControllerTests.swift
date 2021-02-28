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
    private typealias SUT = SingleResponsibilityController
    
    func test_initializationDoesNotSave() {
        let (_, handler) = makeSUT()
        XCTAssertEqual(handler.triggeredActions, [], "Save was triggered on initialization.")
    }
    
    func test_controllerLoadDoesNotSave() {
        let (sut, handler) = makeSUT()
        loadSUT(sut)
        XCTAssertEqual(handler.triggeredActions, [], "Save was triggered on load.")
    }
    
    func test_saveOnUserTapSaveButton() {
        let (sut, handler) = makeSUT()

        loadSUT(sut)
        simulateUserDidTapOnSaveButton(sut)
        
        XCTAssertEqual(handler.triggeredActions, [.save], "Save was triggered on load.")
    }
    
    // MARK: Helpers
    private func simulateUserDidTapOnSaveButton(_ sut: SUT, expectation: XCTestExpectation? = nil) {
//        DispatchQueue.main.async {
//            sut.saveButton.sendActions(for: .touchUpInside)
//            expectation.fulfill()
//        }
        // FIXME: Do correct button user push simulation...
        // Temporal replacement
        sut.saveButtonHandler()
    }
    
    private func loadSUT(_ sut: SUT) {
        sut.loadViewIfNeeded()
    }
    
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
