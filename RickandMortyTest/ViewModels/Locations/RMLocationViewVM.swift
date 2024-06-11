//
//  RMLocationViewVM.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 10/06/2024.
//

import Foundation

protocol RMLocationViewVMDelegate: AnyObject {
    func didFetchInitialLocations()
}

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
    
    private var apiInfo: RMGetAllLocationsResponse.Info?
    public private(set) var cellViewModels: [RMLocationTableViewCellVM] = []
    
    init() {}
    
    public func fetchLocations() {
        Task {
            let model: RMGetAllLocationsResponse = try await RMService.shared.execute(request: .listLocationsRequest)
            apiInfo = model.info
            locations = model.results
        }
        delegate?.didFetchInitialLocations()
    }
    
    private var hasMoreResults: Bool {
        return false
    }
}
