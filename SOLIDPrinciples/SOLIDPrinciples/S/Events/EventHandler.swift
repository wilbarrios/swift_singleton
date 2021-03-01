//
//  EventHandler.swift
//  SOLIDPrinciples
//
//  Created by Wilmer Barrios on 28/02/21.
//

import Foundation

class EventHandler {
    var lastSentEvent: Event?
    
    let service: EventService
    
    init(service: EventService) {
        self.service = service
    }
    
    func sendEvent(_ event: Event, completion: @escaping (Error?) -> Void = {_ in }) {
        lastSentEvent = event
        service.send(event: event.eventId, completion: completion)
    }
}
