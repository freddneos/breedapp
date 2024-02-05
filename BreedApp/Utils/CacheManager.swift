//
//  CacheManager2.swift
//  BreedApp
//
//  Created by Fredd Bezerra on 05/02/2024.
//

import Foundation

import Foundation

public class CacheManager {
    static let shared = CacheManager()
    private let userDefaults = UserDefaults.standard
    private let cacheTimeInterval: TimeInterval = 1200 // 20 minutes
    
    private init() {}
    
    func cacheKeyForTimestamp(_ key: String) -> String {
        "Timestamp_\(key)"
    }
    
    func isCacheValid(forKey key: String) -> Bool {
        let timestampKey = cacheKeyForTimestamp(key)
        if let timestamp = userDefaults.object(forKey: timestampKey) as? Date {
            return Date().timeIntervalSince(timestamp) < cacheTimeInterval
        }
        return false
    }
    
    func updateCacheTimestamp(forKey key: String) {
        let timestampKey = cacheKeyForTimestamp(key)
        userDefaults.set(Date(), forKey: timestampKey)
    }
    
    func cacheData<T: Codable>(_ data: T, forKey key: String) {
        do {
            let encodedData = try JSONEncoder().encode(data)
            userDefaults.set(encodedData, forKey: key)
            updateCacheTimestamp(forKey: key)
        } catch {
            print("Failed to cache data for key \(key): \(error)")
        }
    }
    
    func getCachedData<T: Codable>(forKey key: String) -> T? {
        guard isCacheValid(forKey: key), let cachedData = userDefaults.data(forKey: key) else {
            return nil
        }
        do {
            return try JSONDecoder().decode(T.self, from: cachedData)
        } catch {
            print("Failed to decode cached data for key \(key): \(error)")
            return nil
        }
    }
}
