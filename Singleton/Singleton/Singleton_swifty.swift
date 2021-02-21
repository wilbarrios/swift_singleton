//
//  Singleton_swifty.swift
//  Singleton
//
//  Created by Wilmer Barrios on 20/02/21.
//

import Foundation

class ApiClientV2 {
    static let instance = ApiClientV2()
    
    private init() {}
}

let clientV2 = ApiClientV2.instance
