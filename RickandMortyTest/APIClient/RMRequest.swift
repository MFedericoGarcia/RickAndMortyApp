//
//  RMRequest.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 15/05/2024.
//

import Foundation

/// Objeto que representa una llamada en particular
final class RMRequest {
    
    /// Constantes de la API
    private struct Constants {
        static let baseURL = "https://rickandmortyapi.com/api"
    }
    
    /// endpoint
    private let endpoint: RMEndPoint
    
    /// componentes (opcionales)
    private let pathComponent: Set<String>
    
    /// querys (opcionales)
    private let queryParameters: [URLQueryItem]
    
    
    
    /// Constructor de URL para el llamado a la API en formato String
    private var urlString: String {
        var string = Constants.baseURL
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponent.isEmpty {
            pathComponent.forEach({
                string += "/\($0)"
            })
        }
        
        if !queryParameters.isEmpty {
            string += "?"
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += argumentString
        }
        
        return string
    }
    
   
    
    // MARK: - Public
    
    public let httpMethod = "GET"
    
    /// URL construida
    public var url: URL? {
        return URL(string: urlString)
    }
    
    public init(endpoint: RMEndPoint, pathComponent: Set<String> = [], queryParameters: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponent = pathComponent
        self.queryParameters = queryParameters
    }
    
}

extension RMRequest {
    static let listCharactersRequest = RMRequest(endpoint: .character)
}
