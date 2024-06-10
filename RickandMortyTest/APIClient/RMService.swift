//
//  RMService.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 15/05/2024.
//

import Foundation

/// Principal service object para obtener data de  Rick and Morty API
final class RMService {
    
    /// Instancia Singleton Comprartida
    static let shared = RMService()
    
    private let cacheManager = RMAPICache()
    
    let decoder = JSONDecoder()
    /// Constructor Privado
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    /// Enviar call a Rick and Morty API
    /// - Parameters:
    ///   - request: Requerir instancia
    ///   - completion: callback con datos o error 
   
    public func execute<T: Codable> (request: RMRequest) async throws -> T {
        
        if let cacheData = cacheManager.cachedResponse(for: request.endpoint, url: request.url){
            do{
                print("Data loaded from cache")
                return try decoder.decode( T.self, from: cacheData)
            } catch {
                throw RMServiceErrors.failedToGetData
            }
        }
        
        
        guard let urlRequest = self.request(from: request) else {throw RMServiceErrors.failedToCreateRequest}
        guard let url = urlRequest.url else {throw RMServiceErrors.failedToCreateRequest}
        
        let (data, _) = try await URLSession.shared.data(from: url)
            
            do{
                let result = try decoder.decode( T.self, from: data)
                self.cacheManager.setCache(for: request.endpoint, url: request.url, data: data)
                return result
            } catch {
                throw RMServiceErrors.failedToGetData
            }
            
    }
    
    
    // MARK: - Private
    
    private func request(from rmRequest: RMRequest) -> URLRequest? {
        guard let url = rmRequest.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod
        
        return request
    }
    
    
}
