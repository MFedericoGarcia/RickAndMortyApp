//
//  RMSearchView.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 12/06/2024.
//

import UIKit

final class RMSearchView: UIView {

    private let viewModel: RMSearchViewVM
    
    // MARK: - Subviews
    
    
    // MARK: - Init
    
    init(frame: CGRect, viewModel: RMSearchViewVM) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .systemRed
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

// MARK: - CollectionView

extension RMSearchView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}
