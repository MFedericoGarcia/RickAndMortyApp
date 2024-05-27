//
//  RMLayoutCompositional.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 25/05/2024.
//

import UIKit

class RMLayoutCompositional: UICollectionViewCompositionalLayout {
    
    
    init(with viewModel: RMCharacterDetailViewVM) {
        super.init { sectionIndex, _ in
            
            let sectionsTypes = viewModel.sections
            switch sectionsTypes[sectionIndex] {
            
            case .photo:
                return viewModel.createPhotoSectionLayout()
                
            case .information:
                return viewModel.createInfoSectionLayout()
                
            case .episodes:
                return viewModel.createEpisodeSectionLayout()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
    

