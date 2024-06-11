//
//  RMLocationTableViewCellVM.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 11/06/2024.
//

import Foundation

struct RMLocationTableViewCellVM: Hashable, Equatable{
   
    
    private let location: RMLocation
    
    init(location: RMLocation) {
        self.location = location
    }
    
    public var name: String {
        return location.name
    }
    public var type: String {
        return location.type
    }
    public var dimension: String {
        return location.dimension
    }
    
    
    static func == (lhs: RMLocationTableViewCellVM, rhs: RMLocationTableViewCellVM) -> Bool {
        return lhs.location.id == rhs.location.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(location.id)
        hasher.combine(dimension)
        hasher.combine(type)
    }
    
}