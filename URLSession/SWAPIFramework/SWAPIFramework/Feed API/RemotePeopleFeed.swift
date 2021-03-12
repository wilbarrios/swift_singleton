//
//  RemotePeopleFeed.swift
//  SWAPIFramework
//
//  Created by Wilmer Barrios on 11/03/21.
//

import Foundation

class RemotePeopleFeed {
    // MARK: Properties
    let client: HTTPClient
    let url: URL
    
    // MARK: Inits
    init(url: URL, client: HTTPClient) {
        self.client = client
        self.url = url
    }
    
    func load(completion: @escaping (NSError?) -> Void) {
        self.client.get(from: url) {
            result in
            switch result {
            case .failure(let e):
                completion(e as NSError)
            default: break
            }
        }
    }
}
