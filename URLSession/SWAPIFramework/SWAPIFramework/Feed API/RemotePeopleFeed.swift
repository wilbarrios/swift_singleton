//
//  RemotePeopleFeed.swift
//  SWAPIFramework
//
//  Created by Wilmer Barrios on 11/03/21.
//

import Foundation

class RemotePeopleFeed {
    enum Error: Swift.Error, Equatable {
        case connectivity
    }
    
    // MARK: Properties
    let client: HTTPClient
    let url: URL
    
    // MARK: Inits
    init(url: URL, client: HTTPClient) {
        self.client = client
        self.url = url
    }
    
    func load(completion: @escaping (Error) -> Void) {
        self.client.get(from: url) {
            result in
            switch result {
            case .failure(_):
                completion(.connectivity)
            default: break
            }
        }
    }
}
