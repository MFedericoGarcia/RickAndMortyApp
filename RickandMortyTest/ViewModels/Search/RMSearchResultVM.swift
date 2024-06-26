//
//  RMSearchResultVM.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 26/06/2024.
//

import Foundation

enum RMSearchResultVM {
    case characters([RMCharacterCollectionViewCellVM])
    case episodes([RMCharacterEpisodeCollectionViewCellVM])
    case location([RMLocationTableViewCellVM])
}
