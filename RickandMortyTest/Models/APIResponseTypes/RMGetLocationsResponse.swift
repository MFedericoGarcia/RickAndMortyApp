//
//  RMGetLocationsResponse.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 11/06/2024.
//

import Foundation

struct RMGetAllLocationsResponse: Codable {
    
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [RMLocation]
}
