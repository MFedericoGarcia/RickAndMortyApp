//
//  RMCharacterDetailView.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 20/05/2024.
//

import UIKit

final class RMCharacterDetailView: UIView {
    
    
    private let  viewModel: RMCharacterDetailViewVM
    private let spinner = RMSpinner(frame: .zero)
    var collectionView: RMCharacterDetailCollectionVIew
    
    
    init(frame: CGRect, viewModel: RMCharacterDetailViewVM) {
        self.viewModel = viewModel
        self.collectionView = RMCharacterDetailCollectionVIew(frame: .zero, collectionViewLayout: UICollectionViewLayout(), viewModel: viewModel)
        super.init(frame: .zero)
        backgroundColor = . systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        configure(with: viewModel)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(with viewModel: RMCharacterDetailViewVM) {
        addSubviews(collectionView, spinner)
        
        
        NSLayoutConstraint.activate([
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
    
}
