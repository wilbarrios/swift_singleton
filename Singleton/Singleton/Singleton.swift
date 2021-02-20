//
//  Singleton.swift
//  Singleton
//
//  Created by Wilmer Barrios on 20/02/21.
//

import Foundation

class ApiClient {
    /// Cant be referenced outside this scope, is constant and doesnt have to exists an instance to reference this property because is `static`
    private static let instance = ApiClient()
    
    /// This function is static because it needs acces to "static scrope" of the ApiClient
    static func getInstance() -> ApiClient {
        return instance
    }
    
    /// Makes the base init a private function, so it can only be called inside of `ApiClient` scope.
    private init() {}
}

//let client = ApiClient()
let client = ApiClient.getInstance()
