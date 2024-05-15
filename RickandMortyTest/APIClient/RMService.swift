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
    
    /// Constructor Privado
    private init() {}
    
    /// Enviar call a Rick and Morty API
    /// - Parameters:
    ///   - request: Requerir instancia
    ///   - completion: callback con datos o error 
    public func execute<T: Codable> (_ request: RMRequest, expecting type: T.Type, completion: @escaping(Result<T, Error>) -> Void) {
        
    }
    
    public func execute2<T: Codable> (request: RMRequest) async throws -> T {
        
        return []
    }
    
    
    
}
