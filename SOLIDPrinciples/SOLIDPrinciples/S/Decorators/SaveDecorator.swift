//
//  SaveDecorator.swift
//  SOLIDPrinciples
//
//  Created by Wilmer Barrios on 28/02/21.
//

import Foundation

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
