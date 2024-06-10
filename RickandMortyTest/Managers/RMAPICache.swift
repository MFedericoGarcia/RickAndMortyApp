//
//  RMAPICache.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 29/05/2024.
//

import Foundation

final class RMAPICache {
   
    private var cacheDictionary: [RMEndPoint: NSCache<NSString, NSData>] = [:]
        
    init() {
        setUpCache()
    }
    // MARK: - Public Functions
    
    public func cachedResponse(for endpoint: RMEndPoint, url: URL?) -> Data? {
        guard let targetCache = cacheDictionary[endpoint], let url = url else {
            return nil
        }
        let key = url.absoluteString as NSString
        return targetCache.object(forKey: key) as? Data
    }
    
    public func setCache (for endpoint: RMEndPoint, url: URL?, data: Data) {
        guard let targetCache = cacheDictionary[endpoint], let url = url else {
            return
        }
        let key = url.absoluteString as NSString
        
        targetCache.setObject(data as NSData, forKey: key)
    }
    
    
    // MARK: - Private Functions
    
    private func setUpCache() {
        RMEndPoint.allCases.forEach({ endpoint in
            cacheDictionary[endpoint] = NSCache<NSString, NSData>()
        })
    }
    
}
