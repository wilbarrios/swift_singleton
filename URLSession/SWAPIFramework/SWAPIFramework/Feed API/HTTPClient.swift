//
//  HTTPClient.swift
//  SWAPIFramework
//
//  Created by Wilmer Barrios on 11/03/21.
//

import Foundation

public typealias HTTPClientResult = Result<HTTPURLResponse, Error>

protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
