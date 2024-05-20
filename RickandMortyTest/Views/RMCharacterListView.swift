//
//  CharacterListView.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 16/05/2024.
//

import UIKit

protocol RMCharacterListViewDelegate: AnyObject {
    func rmCharacterList(_ characterListView: RMCharacterListView, didSelectCharacter character: RMCharacter)
}

/// View que se encarga de mostrar la lista de personajes
final class RMCharacterListView: UIView {
    
    public weak var delegate: RMCharacterListViewDelegate?
    
    private let viewModel = RMCharacterListViewVM()
    private let spinner = RMSpinner(frame: .zero)
    private let collectionView = RMCharacterListCollectionView(frame: .zero)
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        configure()
        spinner.startAnimating()
        viewModel.fetchCharacters()
        viewModel.delegate = self
        setUpCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubviews(spinner, collectionView)
        
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
    
    private func setUpCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
    
    
}

extension RMCharacterListView: RMCharacterListViewVMDelegate {
    func didSelectCharacter(_ character: RMCharacter) {
        delegate?.rmCharacterList(self, didSelectCharacter: character)
    }
    
    func didLoadInitialCharacters() {
    
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.spinner.stopAnimating()
            self.collectionView.isHidden = false
            UIView.animate(withDuration: 0.4){
                self.collectionView.alpha = 1
            }
        }
        
       
    }
    
    
    
}
