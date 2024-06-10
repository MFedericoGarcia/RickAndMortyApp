//
//  RMEpisodeDetailViewVM.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 29/05/2024.
//

import UIKit



protocol RMEpisodeDetailViewVMDelegate: AnyObject {
    func didFetchEpisodeDetails()
}

class RMEpisodeDetailViewVM {
    
    // MARK: - Variables
    
    private let endpointUrl: URL?
    private var dataTuple: (episode: RMEpisode, characters: [RMCharacter])? {
        didSet {
            createCellViewModels()
            delegate?.didFetchEpisodeDetails()
        }
    }
    
    
    enum SectionType {
        case information(viewModels: [RMEpisodeInfoCollectionViewCellVM])
        case characters(viewModels: [RMCharacterCollectionViewCellVM])
    }
    
    public private(set) var cellViewModels: [SectionType] = []
   
    
    public weak var delegate: RMEpisodeDetailViewVMDelegate?
    
    // MARK: - Init
    
    init(endpointUrl: URL?) {
        self.endpointUrl = endpointUrl
    }
    
    public func character(at index: Int) -> RMCharacter? {
        guard let dataTuple = dataTuple else { return nil }
        return dataTuple.characters[index]
    }
    
    // MARK: - Public
    
    public func fetchEpisodeData() {
        guard let endpointUrl = endpointUrl else { return }
        guard let request = RMRequest(url: endpointUrl) else {
            return
        }
        Task {
            do{
                let response: RMEpisode = try await RMService.shared.execute(request: request)
                await fetchRelatedCharacters(episode: response)
                print(String(describing: response))
            } catch {
                print("Error")
            }
        }
        
    }
    
    // MARK: - Private
   
    private func fetchRelatedCharacters(episode: RMEpisode) async {
        
        let characterUrl: [URL] = episode.characters.compactMap ({
            return URL(string: $0)
        })
        let requests: [RMRequest] = characterUrl.compactMap({
            return RMRequest(url: $0)
        })
        
        var characters: [RMCharacter] = []
        
        for request in requests {
            do {
                let result: RMCharacter = try await RMService.shared.execute(request: request)
                characters.append(result)
                dataTuple = (episode: episode, characters: characters)
            } catch {
                return
            }
        }
        
    }
    
    private func createCellViewModels() {
        guard let dataTuple = dataTuple else { return }
        let episode = dataTuple.episode
        let characters = dataTuple.characters
        
    
        guard let createdDate = RMCharacterInfoCollectionViewCellVM.dateFormatter.date(from: episode.created) else { return print("NO ANDA") }
        let createdString = createdDate.convertToMonthYearFormat()

        

        
        cellViewModels = [
            .information(viewModels: [
                .init(title: "Episode Name", value: episode.name),
                .init(title: "Air Date ", value: episode.airDate),
                .init(title: "Episode", value: episode.episode),
                .init(title: "Created", value: createdString),
            ]),
            .characters(viewModels: characters.compactMap({ character in
                return RMCharacterCollectionViewCellVM(characterName: character.name, characterStatus: character.status, characterImageUrl: URL(string: character.image))
            }))
        ]
    }
    
    
    
    
}

extension RMEpisodeDetailViewVM {
    
    
    public func createInfoSectionLayout() -> NSCollectionLayoutSection {
        
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50)), subitems: [item, item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    public func createEpisodeSectionLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(260)), subitems: [item, item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
}
