//
//  RMEndPoint.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 15/05/2024.
//

import Foundation

/// Api endpoint para cada llamado 
@frozen enum RMEndPoint: String, Hashable, CaseIterable {
    case character = "character"
    case location = "location"
    case episode = "episode"
}
