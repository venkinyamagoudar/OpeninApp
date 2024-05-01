//
//  MemoryCache.swift
//  OpeninApp
//
//  Created by Venkatesh Nyamagoudar on 5/1/24.
//

import SwiftUI

/// Protocol defining the interface for a memory cache.
protocol MemoryCache {
    func get<T>(for key: String) -> T?
    func set<T>(value: T, for key: String)
}

/// Implementation of the `MemoryCache` protocol.
class MemoryCacheImpl: MemoryCache {
    private var cache: [String: Any] = [:]
    private let syncQueue = DispatchQueue(label: "com.example.memorycache.syncQueue")
    
    /// Retrieves the value associated with the given key from the cache.
    /// - Parameters:
    ///   - key: The key used to retrieve the value from the cache.
    /// - Returns: The value associated with the key, if present; otherwise, nil.
    func get<T>(for key: String) -> T? {
        syncQueue.sync {
            return cache[key] as? T
        }
    }
    
    /// Sets the value for the specified key in the cache.
    /// - Parameters:
    ///   - value: The value to be stored in the cache.
    ///   - key: The key used to store the value in the cache.
    func set<T>(value: T, for key: String) {
        syncQueue.async {
            self.cache[key] = value
        }
    }
}
