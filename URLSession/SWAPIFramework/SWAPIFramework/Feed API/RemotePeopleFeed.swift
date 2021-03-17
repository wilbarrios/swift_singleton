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
        case invalidData
    }
    
    typealias Result = Swift.Result<[PersonItem], Error>
    
    // MARK: Properties
    let client: HTTPClient
    let url: URL
    
    // MARK: Inits
    init(url: URL, client: HTTPClient) {
        self.client = client
        self.url = url
    }
        
    func load(completion: @escaping (Result) -> Void) {
        self.client.get(from: url) {
            result in
            switch result {
            case .success((let data, let response)):
                if response.statusCode == 200, let people = try? RemotePeopleFeed.map(data) {
                    completion(.success(people))
                } else {
                    completion(.failure(.invalidData))
                }
            case .failure(_):
                completion(.failure(.connectivity))
            }
        }
    }
    
    private static func map(_ data: Data) throws -> [PersonItem] {
        let persons = try JSONDecoder().decode(Root.self, from: data)
        return persons.results.map({ $0.item })
    }
}

private struct Root: Decodable {
    let results: [RemotePersonItem]
}

/// To avoid tight coupling to API implementation details
private struct RemotePersonItem: Equatable, Decodable {
    var name: String
    var height: String
    var gender: String
    
    var item: PersonItem {
        PersonItem(name: name, height: height, gender: gender)
    }
}
