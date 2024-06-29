//
//  RMLocationViewVM.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 10/06/2024.
//

import Foundation

// MARK: - Protocol

protocol RMLocationViewVMDelegate: AnyObject {
    func didFetchInitialLocations()
}

// MARK: - ViewModel

final class RMLocationViewVM {
    
    weak var delegate: RMLocationViewVMDelegate?
    
    private var locations: [RMLocation] = [] {
        didSet {
            for location in locations {
                let cellViewModel = RMLocationTableViewCellVM(location: location)
                
                if !cellViewModels.contains(cellViewModel) {
                    cellViewModels.append(cellViewModel)
                }
               
            }
        }
    }
    
    
    
    
    // LOCATION INFO
    
    private var hasMoreResults: Bool {
        return false
    }
    
    private var didFinishPagination: (() -> Void)?

    
    
    private var apiInfo: RMGetAllLocationsResponse.Info?
    
    public private(set) var cellViewModels: [RMLocationTableViewCellVM] = []
    public var shouldShowLoadMoreIndicator: Bool {
        return  apiInfo?.next != nil
    }
    public var isLoadingMoreLocations = false
    
    
    // MARK: - Init
    
    init() {}
    
    
    // MARK: - Public Funcs
    
    public func registerDidFinishPagination(_ block: @escaping() -> Void) {
        self.didFinishPagination = block
    }
    public func fetchLocations() {
        Task {
            let model: RMGetAllLocationsResponse = try await RMService.shared.execute(request: .listLocationsRequest)
            apiInfo = model.info
            locations = model.results
        }
        delegate?.didFetchInitialLocations()
    }
    
    public func fetchAdditionalLocations() {
        
        guard !isLoadingMoreLocations else {
            return
        }
        isLoadingMoreLocations = true
        guard let nextUrlString = apiInfo?.next,
              let url = URL(string: nextUrlString) else { return }
        
        guard let request = RMRequest(url: url) else {
            return
        }
        Task {
            do {
                let response: RMGetAllLocationsResponse = try await RMService.shared.execute(request: request)

                let moreResults = response.results
                
                apiInfo = response.info
                cellViewModels.append(contentsOf: moreResults.compactMap({
                    return RMLocationTableViewCellVM(location: $0 )
                }))
                isLoadingMoreLocations = false
                didFinishPagination?()
                
            } catch {
                print(error.localizedDescription)
                isLoadingMoreLocations = false

            }
        }
    }
    
    
    public func location(at index: Int) -> RMLocation? {
        guard index < locations.count, index >= 0 else {
            return nil
        }
        return self.locations[index]
    }
    
    // MARK: - Private Funcs
    
   
}
