//
//  SaveHandlerMock.swift
//  SOLIDPrinciplesTests
//
//  Created by Wilmer Barrios on 28/02/21.
//

import Foundation
@testable import SOLIDPrinciples

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
