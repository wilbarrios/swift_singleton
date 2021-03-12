//
//  RemotePeopleFeedTests.swift
//  SWAPIFrameworkTests
//
//  Created by Wilmer Barrios on 11/03/21.
//

import Foundation
import XCTest

protocol HTTPClient {
    func get(from url: URL)
}

class RemotePeopleFeed {
    // MARK: Properties
    let client: HTTPClient
    
    // MARK: Inits
    init(client: HTTPClient) {
        self.client = client
    }
}

class RemotePeopleFeedTests: XCTestCase {
    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        
        XCTAssertNil(client.requestedURL, "Initialization requests data from URL")
    }
    
    // MARK: Helpers
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: RemotePeopleFeed, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemotePeopleFeed(client: client)
        trackMemoryLeaks(client, file: file, line: line)
        trackMemoryLeaks(sut, file: file, line: line)
        return (sut, client)
    }
    
    // MARK: Testing entities
    
    private class HTTPClientSpy: HTTPClient {
        var requestedURL: URL?
        
        func get(from url: URL) {
            
        }
    }
}
