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
    public let endpoint: RMEndPoint
    
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
    
    
    convenience init?(url: URL) {
        let string = url.absoluteString
        if !string.contains(Constants.baseURL) {
            return nil
        }
        
        let trimmed = string.replacingOccurrences(of: Constants.baseURL+"/", with: "")
        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty {
                let endpointString = components[0]
                var pathComponents: [String] = []
                if components.count > 1 {
                    pathComponents = components
                    pathComponents.removeFirst()
                }
                
                
                if let rmEndpoint = RMEndPoint(rawValue: endpointString){
                    self.init(endpoint: rmEndpoint, pathComponent: Set(pathComponents))
                    return
                }
            }
        }
            else if trimmed.contains("?") {
                let components = trimmed.components(separatedBy: "?")
                if !components.isEmpty, components.count >= 2 {
                    let endpointString = components[0]
                    let queryItemsString = components[1]
                    let queryItems: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({
                        guard $0.contains("=") else { return nil}
                        let parts = $0.components(separatedBy: "=")
                        
                        return URLQueryItem(name: parts[0], value: parts[1])
                    })
                    
                    if let rmEndpoint = RMEndPoint(rawValue: endpointString){
                        self.init(endpoint: rmEndpoint, queryParameters: queryItems)
                        return
                    }
                }
            }
            
            return nil
        
    }
}

extension RMRequest {
    static let listCharactersRequest = RMRequest(endpoint: .character)
    static let listEpisodesRequest = RMRequest(endpoint: .episode)
}
