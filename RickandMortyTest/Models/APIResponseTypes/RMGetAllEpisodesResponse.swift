//
//  RMGetAllEpisodesResponse.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 29/05/2024.
//

import Foundation

struct RMGetAllEpisodesResponse: Codable {
    
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [RMEpisode]
}
