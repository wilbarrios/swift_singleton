//
//  LoginService.swift
//  LoginCleanArchitectureApp
//
//  Created by Wilmer Barrios on 03/03/21.
//

import Foundation

protocol LoginService {
    func login(username: String, password: String, completion: @escaping (Error?) -> Void)
}
