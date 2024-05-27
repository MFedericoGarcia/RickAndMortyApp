//
//  RMCharacterCollectionViewCellVM.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 17/05/2024.
//

import Foundation

final class RMCharacterCollectionViewCellVM: Hashable, Equatable {
    
    public let characterName: String
    private let characterStatus: RMCharacterStatus
    private let characterImageUrl: URL?
    
    static func == (lhs: RMCharacterCollectionViewCellVM, rhs: RMCharacterCollectionViewCellVM) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterStatus)
        hasher.combine(characterImageUrl)
    }
    
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

        let data = try await RMImageLoader.shared.downloadImage(url)
        return data
    }
    
}
