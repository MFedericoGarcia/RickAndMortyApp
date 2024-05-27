//
//  RMCharacterEpisodeCollectionViewCell.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 27/05/2024.
//

import UIKit

final class RMCharacterEpisodeCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "RMCharacterEpisodeCollectionViewCell"
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        
    }
    
    func configure(with: RMCharacterEpisodeCollectionViewCellVM) {
        
    }
}
