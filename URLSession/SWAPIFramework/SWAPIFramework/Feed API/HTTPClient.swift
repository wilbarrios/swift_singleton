//
//  HTTPClient.swift
//  SWAPIFramework
//
//  Created by Wilmer Barrios on 11/03/21.
//

import Foundation

protocol HTTPClient {
    func get(from url: URL)
}
