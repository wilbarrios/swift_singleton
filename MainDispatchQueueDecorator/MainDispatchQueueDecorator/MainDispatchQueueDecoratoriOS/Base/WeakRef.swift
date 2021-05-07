//
//  WeakRef.swift
//  MainDispatchQueueDecoratoriOS
//
//  Created by Wilmer Barrios on 06/05/21.
//

import Foundation

public class WeakRef<T> {
    internal let decoratee: T
    
    public init(_ decoratee: T) {
        self.decoratee = decoratee
    }
    
    public func dispatch(_ completion: @escaping (() -> Void)) {
        guard Thread.isMainThread else { DispatchQueue.main.async(execute: completion); return }
        completion()
    }
}
