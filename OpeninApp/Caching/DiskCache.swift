//
//  DiskCache.swift
//  OpeninApp
//
//  Created by Venkatesh Nyamagoudar on 5/1/24.
//

import SwiftUI

/// Protocol defining the interface for a disk cache.
protocol DiskCache {
    func get<T:Codable>(for key: String) -> T?
    func set<T:Codable>(value: T, for key: String)
}

class DiskCacheImpl: DiskCache {
    
    private let fileManager = FileManager.default
    private let cacheDirectory: URL
    
    /// Initializes the `DiskCacheImpl` instance.
    init() {
        self.cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!.appendingPathComponent("DataCache")
        do {
            try FileManager.default.createDirectory(at: cacheDirectory, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Error creating cache directory: \(error)")
        }
    }
    
    /// Retrieves the value associated with the given key from the disk cache.
    /// - Parameters:
    ///   - key: The key used to retrieve the value from the disk cache.
    /// - Returns: The value associated with the key, if present; otherwise, nil.
    func get<T: Codable>(for key: String) -> T? {
        let fileURL = cacheDirectory.appendingPathComponent(key)
        guard fileManager.fileExists(atPath: fileURL.path) else { return nil }
        do {
            let data = try Data(contentsOf: fileURL)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("Error loading data from disk: \(error)")
            return nil
        }
    }
    
    /// Sets the value for the specified key in the disk cache.
    /// - Parameters:
    ///   - value: The value to be stored in the disk cache.
    ///   - key: The key used to store the value in the disk cache.
    func set<T:Codable>(value: T, for key: String) {
        let fileURL = cacheDirectory.appendingPathComponent(key)
        do {
            let data = try JSONEncoder().encode(value)
            try data.write(to: fileURL)
        } catch {
            print("Error saving data to disk: \(error)")
        }
    }
}
