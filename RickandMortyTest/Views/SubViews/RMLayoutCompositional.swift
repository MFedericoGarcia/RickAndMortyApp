//
//  RMLayoutCompositional.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 25/05/2024.
//

import UIKit

class RMLayoutCompositional: UICollectionViewCompositionalLayout {
    
    
    init( withCharacter viewModel: RMCharacterDetailViewVM) {
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
    
    init( withLocation viewModel: RMLocationDetailViewVM) {
        super.init { sectionIndex, _ in
            
            let sectionsTypes = viewModel.cellViewModels

            switch sectionsTypes[sectionIndex] {
                
            case .information:
                return viewModel.createInfoSectionLayout()
                
            case .characters:
                return viewModel.createEpisodeSectionLayout()
            }
        }
    }
    
    
    init( withEpisode viewModel: RMEpisodeDetailViewVM) {
        
        super.init { sectionIndex, _ in
            let sectionsTypes = viewModel.cellViewModels
            
            switch sectionsTypes[sectionIndex] {
                
            case .information:
                return viewModel.createInfoSectionLayout()
                
            case .characters:
                return viewModel.createEpisodeSectionLayout()
            }
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
    

