//
//  CharacterListCollectionView.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 16/05/2024.
//

import UIKit

class RMCharacterListCollectionView: UICollectionView {
    

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: RMLayoutFlow())
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.isHidden = true
        self.alpha = 0
        self.translatesAutoresizingMaskIntoConstraints = false
        self.register(RMCharacterCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterCollectionViewCell.identifier)
        self.register(RMFooterLoadingCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier)
        
    }
}
