//
//  InMemoryDataManager.swift
//  SOLIDPrinciples
//
//  Created by Wilmer Barrios on 28/02/21.
//

import Foundation

class InMemoryDataManager {
    struct InMemoryDataModel: Equatable { }
    
    var storedItems = [String: InMemoryDataModel]()
    
    func store(id: String, item: InMemoryDataModel) {
        storedItems[id] = item
    }
    
    func retreive(id: String) -> InMemoryDataModel? {
        return storedItems[id]
    }
}
