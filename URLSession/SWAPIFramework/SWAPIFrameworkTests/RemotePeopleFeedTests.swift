//
//  RemotePeopleFeedTests.swift
//  SWAPIFrameworkTests
//
//  Created by Wilmer Barrios on 11/03/21.
//

import Foundation
import XCTest
@testable import SWAPIFramework

class RemotePeopleFeedTests: XCTestCase {
    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        
        XCTAssertTrue(client.requestedURLs.isEmpty, "Initialization requests data from URL")
    }
    
    func test_load_requestsDataFromURL() {
        let url = makeAnyURL()
        let (sut, client) = makeSUT(url: url)
        
        sut.load { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_loadTwice_requestDataFromURLTwice() {
        let url = makeAnyURL()
        let (sut, client) = makeSUT(url: url)
        
        sut.load { _ in }
        sut.load { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    func test_load_deliversConnectivityErrorOnClientError() {
        let (sut, client) = makeSUT()
        
        let clientError = makeAnyError()
        var capturedErrors = [RemotePeopleFeed.Error]()
        sut.load {
            error in
            capturedErrors.append(error)
        }
        
        client.complete(withError: clientError)
        
        XCTAssertEqual(capturedErrors, [.connectivity]) // We consider order and quantity
    }
    
    // MARK: Helpers
    
    private func makeAnyError() -> NSError {
        return NSError(domain: "anyDomain", code: 1, userInfo: nil)
    }
    
    private func makeAnyURL() -> URL {
        return URL(string: "https://any-url.com")!
    }
    
    private func makeSUT(url: URL = URL(string: "http://any-url.com")!, file: StaticString = #file, line: UInt = #line) -> (sut: RemotePeopleFeed, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemotePeopleFeed(url: url, client: client)
        trackMemoryLeaks(client, file: file, line: line)
        trackMemoryLeaks(sut, file: file, line: line)
        return (sut, client)
    }
    
    // MARK: Testing entities
    
    private class HTTPClientSpy: HTTPClient {
        
        private typealias HTTPClientCompletionHandler = (HTTPClientResult) -> Void
        
        private var messages = [(url: URL, completion: HTTPClientCompletionHandler)]() // If we need to consider more values, we just need to add it to the tuple
        
        var requestedURLs: [URL] {
            return messages.map({ $0.url })
        }
        
        private var completions: [HTTPClientCompletionHandler] {
            return messages.map({ $0.completion })
        }
        
        func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
            messages.append((url, completion))
        }
        
        func complete(withError error: NSError, index: Int = 0) {
            completions[index](.failure(error))
        }
    }
}
