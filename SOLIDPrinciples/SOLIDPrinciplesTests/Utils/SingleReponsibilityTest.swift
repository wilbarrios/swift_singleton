//
//  SingleReponsibilityTest.swift
//  SOLIDPrinciplesTests
//
//  Created by Wilmer Barrios on 28/02/21.
//

import Foundation
import XCTest
@testable import SOLIDPrinciples

protocol SingleResponibilityTest: XCTestCase {}

extension SingleResponibilityTest {
    func simulateUserDidTapOnSaveButton(_ sut: SingleResponsibilityController, expectation: XCTestExpectation? = nil) {
//        DispatchQueue.main.async {
//            sut.saveButton.sendActions(for: .touchUpInside)
//            expectation.fulfill()
//        }
        // FIXME: Do correct button user push simulation...
        // Temporal replacement
        sut.saveButtonHandler()
    }
}
