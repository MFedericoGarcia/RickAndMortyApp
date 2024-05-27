//
//  RMImageLoader.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 22/05/2024.
//

import Foundation

final class RMImageLoader {
    static let shared = RMImageLoader()
    private var imageDataCache = NSCache<NSString, NSData>()
    
    private init() {
        
    }
    
    /// Obtener la imagen con url
    /// - Parameter url: fuente URL
    /// - Returns: callback
    public func downloadImage(_ url: URL) async throws -> Data {
        
        let key = url.absoluteString as NSString
        if let data = imageDataCache.object(forKey: key) {
          return data as Data
        }
        
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(from: request.url!)

        
        let value = data as NSData
        imageDataCache.setObject(value, forKey: key)
        
        return data
    }
}
