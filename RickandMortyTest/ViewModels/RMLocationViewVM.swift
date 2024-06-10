//
//  RMLocationViewVM.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 10/06/2024.
//

import Foundation

final class RMLocationViewVM {
    
    private var locations: [RMLocation] = []
    
    // LOCATION INFO
    
    private var cellViewModels: [String] = []
    
    init() {}
    
    public func fetchLocations() {
        Task {
            let model:[RMLocation] = try await RMService.shared.execute(request: .listLocationsRequest)
            locations = model
        }
    }
    
    private var hasMoreResults: Bool {
        return false
    }
}
