//
//  DiskCache.swift
//  OpeninApp
//
//  Created by Venkatesh Nyamagoudar on 5/1/24.
//

import SwiftUI

protocol DiskCache {
    func get<T:Codable>(for key: String) -> T?
    func set<T:Codable>(value: T, for key: String)
}

class DiskCacheImpl: DiskCache {
    
    private let fileManager = FileManager.default
    private let cacheDirectory: URL
    
    init() {
        self.cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!.appendingPathComponent("DataCache")
        do {
            try FileManager.default.createDirectory(at: cacheDirectory, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Error creating cache directory: \(error)")
        }
    }
    
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
