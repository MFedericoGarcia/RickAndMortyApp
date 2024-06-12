//
//  RMLocationDetailViewVM.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 12/06/2024.
//

import Foundation

import UIKit



protocol RMLocationDetailViewVMDelegate: AnyObject {
    func didFetchLocationDetails()
}

class RMLocationDetailViewVM {
    
    // MARK: - Variables
    
    private let endpointUrl: URL?
    private var dataTuple: (location: RMLocation, characters: [RMCharacter])? {
        didSet {
            createCellViewModels()
            delegate?.didFetchLocationDetails()
        }
    }
    
    
    enum SectionType {
        case information(viewModels: [RMLocationInfoCollectionViewCellVM])
        case characters(viewModels: [RMCharacterCollectionViewCellVM])
    }
    
    public private(set) var cellViewModels: [SectionType] = []
   
    
    public weak var delegate: RMLocationDetailViewVMDelegate?
    
    // MARK: - Init
    
    init(endpointUrl: URL?) {
        self.endpointUrl = endpointUrl
    }
    
    public func character(at index: Int) -> RMCharacter? {
        guard let dataTuple = dataTuple else { return nil }
        return dataTuple.characters[index]
    }
    
    // MARK: - Public
    
    public func fetchLocationData() {
        guard let endpointUrl = endpointUrl else { return }
        guard let request = RMRequest(url: endpointUrl) else {
            return
        }
        Task {
            do{
                let response: RMLocation = try await RMService.shared.execute(request: request)
                await fetchRelatedCharacters(location: response)
            } catch {
                print("Error")
            }
        }
        
    }
    
    // MARK: - Private
   
    private func fetchRelatedCharacters(location: RMLocation) async {
        let characterUrl: [URL] = location.residents.compactMap ({
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
                dataTuple = (location: location, characters: characters)
            } catch {
                return
            }
        }
        
    }
    
    private func createCellViewModels() {
        guard let dataTuple = dataTuple else { return }
        let location = dataTuple.location
        let characters = dataTuple.characters
        
        guard let createdDate = RMCharacterInfoCollectionViewCellVM.dateFormatter.date(from: location.created) else { return print("NO ANDA") }
        let createdString = createdDate.convertToMonthYearFormat()

        
        cellViewModels = [
            .information(viewModels: [
                .init(title: "Location Name", value: location.name),
                .init(title: "Type ", value: location.type),
                .init(title: "Dimension", value: location.dimension),
                .init(title: "Created", value: createdString),
            ]),
            .characters(viewModels: characters.compactMap({ character in
                return RMCharacterCollectionViewCellVM(characterName: character.name, characterStatus: character.status, characterImageUrl: URL(string: character.image))
            }))
        ]
    }
    
    
    
    
}

extension RMLocationDetailViewVM {
    
    
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
