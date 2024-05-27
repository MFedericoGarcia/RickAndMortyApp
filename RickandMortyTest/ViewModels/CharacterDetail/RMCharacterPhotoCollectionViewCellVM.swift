//
//  RMCharacterPhotoCollectionViewCellVM.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 27/05/2024.
//

import Foundation

final class RMCharacterPhotoCollectionViewCellVM {
    private let imageUrl: URL?
    
    init(imageUrl: URL?) {
        self.imageUrl = imageUrl
    }
    
    
    public func fetchImage() async throws -> Data {
        
        guard let url = imageUrl else { throw URLError(.badURL) }

        let data = try await RMImageLoader.shared.downloadImage(url)
        return data
    }
    
}
