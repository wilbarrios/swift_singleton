//
//  EventServiceMock.swift
//  SOLIDPrinciplesTests
//
//  Created by Wilmer Barrios on 28/02/21.
//

import Foundation
@testable import SOLIDPrinciples

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
