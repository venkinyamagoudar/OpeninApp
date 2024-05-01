//
//  MemoryCache.swift
//  OpeninApp
//
//  Created by Venkatesh Nyamagoudar on 5/1/24.
//

import SwiftUI

protocol MemoryCache {
    func get<T>(for key: String) -> T?
    func set<T>(value: T, for key: String)
}

class MemoryCacheImpl: MemoryCache {
    private var cache: [String: Any] = [:]
    private let syncQueue = DispatchQueue(label: "com.example.memorycache.syncQueue")
    
    func get<T>(for key: String) -> T? {
        syncQueue.sync {
            return cache[key] as? T
        }
    }
    
    func set<T>(value: T, for key: String) {
        syncQueue.async {
            self.cache[key] = value
        }
    }
}
