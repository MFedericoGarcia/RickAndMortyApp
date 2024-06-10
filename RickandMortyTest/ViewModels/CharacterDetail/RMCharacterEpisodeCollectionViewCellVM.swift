//
//  RMCharacterEpisodeCollectionViewCellVM.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 27/05/2024.
//

import UIKit

protocol RMEpisodeDataRender {
    var name: String { get }
    var airDate: String { get }
    var episode: String { get }
}

final class RMCharacterEpisodeCollectionViewCellVM: Hashable, Equatable {
    
    
    private let episodeDataUrl: URL?
    private var isFetching = false
    private var dataBlock: ((RMEpisodeDataRender) -> Void)?
    
    public let borderColor: UIColor
    
    private var episode: RMEpisode? {
        didSet {
            guard let model = episode else {
                return
            }
            dataBlock?(model)
        }
    }
    
    //MARK: -- INIT
    
    init(episodeDataUrl: URL?, borderColor: UIColor = .systemBlue) {
        self.episodeDataUrl = episodeDataUrl
        self.borderColor = borderColor
    }
    
    public func registerForData(_ block: @escaping(RMEpisodeDataRender) -> Void) {
        self.dataBlock = block
    }
    
    public func fetchEpisode() {
        guard !isFetching else {
            if let model = episode {
                self.dataBlock?(model)
            }
            return
        }
        
        guard let url = episodeDataUrl, let request = RMRequest(url: url) else {
            return
        }
        
        isFetching = true
        
        Task {
            do{
                let response: RMEpisode = try await RMService.shared.execute(request: request)
                self.episode = response
            } catch {
                throw error
            }
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.episodeDataUrl?.absoluteString ?? "")
    }
    
    static func == (lhs: RMCharacterEpisodeCollectionViewCellVM, rhs: RMCharacterEpisodeCollectionViewCellVM) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
