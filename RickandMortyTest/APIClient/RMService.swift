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
    public func execute (_ request: RMRequest, completion: @escaping() -> Void) {
        
    }
}
