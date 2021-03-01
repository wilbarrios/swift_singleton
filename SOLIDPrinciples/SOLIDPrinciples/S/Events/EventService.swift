//
//  EventService.swift
//  SOLIDPrinciples
//
//  Created by Wilmer Barrios on 28/02/21.
//

import Foundation

protocol EventService {
    func send(event: String, completion: @escaping (Error?) -> Void)
}
