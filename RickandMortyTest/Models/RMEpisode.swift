//
//  RMEpisode.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 15/05/2024.
//

import Foundation

struct RMEpisode: Codable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}
