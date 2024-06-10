//
//  RMEpisodeDetailCollectionView.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 31/05/2024.
//

import UIKit

class RMEpisodeDetailCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout = RMLayoutFlow()) {
        super.init(frame: frame, collectionViewLayout: layout)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        isHidden = true
        alpha = 0
        translatesAutoresizingMaskIntoConstraints = false
        self.register(RMEpisodeInfoCollectionViewCell.self , forCellWithReuseIdentifier: RMEpisodeInfoCollectionViewCell.cellIdentifier)
        self.register(RMCharacterCollectionViewCell.self , forCellWithReuseIdentifier: RMCharacterCollectionViewCell.identifier)

    }

}
