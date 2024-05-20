//
//  RMCharacterCollectionViewCellVM.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 17/05/2024.
//

import Foundation

final class RMCharacterCollectionViewCellVM {
    
    public let characterName: String
    private let characterStatus: RMCharacterStatus
    private let characterImageUrl: URL?
    
    init(
        characterName: String,
        characterStatus: RMCharacterStatus,
        characterImageUrl: URL?
    ) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageUrl = characterImageUrl
    }
    
    public var characterStatusText: String {
        return " Status: \(characterStatus.text)"
    }
    
    public func fetchImage() async throws -> Data {
        
        guard let url = characterImageUrl else { throw URLError(.badURL) }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        return data
    }
    
}
