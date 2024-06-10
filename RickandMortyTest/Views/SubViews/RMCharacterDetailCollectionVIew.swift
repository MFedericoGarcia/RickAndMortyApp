//
//  RMCharacterDetailCollectionVIew.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 24/05/2024.
//

import UIKit

class RMCharacterDetailCollectionVIew: UICollectionView {
    
    let viewModel: RMCharacterDetailViewVM
    let layout2: RMLayoutCompositional
   
    init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout, viewModel: RMCharacterDetailViewVM) {
        self.viewModel = viewModel
        self.layout2 = RMLayoutCompositional(withCharacter: viewModel)
        super.init(frame: frame, collectionViewLayout: layout2)
        configure()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.register(RMCharacterPhotoCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterPhotoCollectionViewCell.cellIdentifier)
        self.register(RMCharacterInfoCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterInfoCollectionViewCell.cellIdentifier)
        self.register(RMCharacterEpisodeCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifier)
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    

}
