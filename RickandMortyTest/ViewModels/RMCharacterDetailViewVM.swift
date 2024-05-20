//
//  RMCharacterDetailViewVM.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 20/05/2024.
//

import Foundation

final class RMCharacterDetailViewVM {
    
    private let character: RMCharacter
    
    init(character: RMCharacter){
        self.character = character
    }
    
    public var title: String {
        character.name.uppercased()
    }
    
}
