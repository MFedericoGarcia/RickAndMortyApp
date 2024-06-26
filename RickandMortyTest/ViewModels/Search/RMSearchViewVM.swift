//
//  RMSearchViewVM.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 12/06/2024.
//

import Foundation

final class RMSearchViewVM {
    
    let config: RMSearchVC.Config
    private var optionMap: [RMSearchInputViewVM.DynamicOption: String] = [:]
    private var searchText = ""
    private var searchResoultHandler: ((RMSearchResultVM) -> Void)?
    private var optionMapUpdateBlock: (((RMSearchInputViewVM.DynamicOption, String)) -> Void)?
    
   
    
    // MARK: - Init
    
    init(config: RMSearchVC.Config) {
        self.config = config
    }
    
    // MARK: - Public
    
    public func registerSearchResoultHandler(_ block: @escaping (RMSearchResultVM) -> Void) {
        self.searchResoultHandler = block
    }
    
    public func set(value: String, for option: RMSearchInputViewVM.DynamicOption) {
        optionMap[option] = value
        let tuple = (option, value)
        optionMapUpdateBlock?(tuple)
    }
    
    public func set(query text: String) {
        self.searchText = text
    }
    
    public func registerOptionChangeBlock(_ block: @escaping((RMSearchInputViewVM.DynamicOption, String)) -> Void) {
        self.optionMapUpdateBlock = block
    }
    
    public func executeSearch() {
        
        
        var queryParams: [URLQueryItem] = [URLQueryItem(name: "name", value: searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))]
        
        queryParams.append(contentsOf: optionMap.enumerated().compactMap({ _, element in
            let key: RMSearchInputViewVM.DynamicOption = element.key
            let value: String = element.value
            return URLQueryItem(name: key.queryArgument, value: value)
        }))
        
        let request = RMRequest(endpoint: config.type.endpoint, queryParameters: queryParams)
        
        Task {
            switch config.type.endpoint {
            case .character:
                let response: RMGetAllCharactersResponse = try await RMService.shared.execute(request: request)
                processSearchResults(model: response)
            case .episode:
                let response: RMGetAllEpisodesResponse = try await RMService.shared.execute(request: request)
                processSearchResults(model: response)
            case .location:
                let response: RMGetAllLocationsResponse = try await RMService.shared.execute(request: request)
                processSearchResults(model: response)
            }
        }
        
        
    }
    
    private func processSearchResults(model: Codable) {
        var resultsVM: RMSearchResultVM?
        
        if let characterResults = model as? RMGetAllCharactersResponse {
            resultsVM = .characters(characterResults.results.compactMap({ return
                RMCharacterCollectionViewCellVM(characterName: $0.name, characterStatus: $0.status, characterImageUrl: URL(string: $0.image))
            }))
        }
        else if let episodeResults = model as? RMGetAllEpisodesResponse{
            resultsVM = .episodes(episodeResults.results.compactMap({ return RMCharacterEpisodeCollectionViewCellVM(episodeDataUrl: URL(string: $0.url))
            }))
        }
        else if let locationResults = model as? RMGetAllLocationsResponse {
            resultsVM = .location(locationResults.results.compactMap({ return 
                RMLocationTableViewCellVM(location: $0)
            }))
        }
        
        if let results = resultsVM {
            self.searchResoultHandler?(results)
        } else {
            
        }
    }
}
