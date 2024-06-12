//
//  RMEpisodeListView.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 29/05/2024.
//

import UIKit

protocol RMEpisodeListViewDelegate: AnyObject {
    func rmEpisodeList(_ characterListView: RMEpisodeListView, didSelectEpisode episode: RMEpisode)
}

/// View que se encarga de mostrar la lista de personajes
final class RMEpisodeListView: UIView {
    
    public weak var delegate: RMEpisodeListViewDelegate?
    
    private let viewModel = RMEpisodeListViewVM()
    private let spinner = RMSpinner(frame: .zero)
    private let collectionView = RMEpisodeListCollectionView(frame: .zero)
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        configure()
        spinner.startAnimating()
        viewModel.fetchEpisodes()
        viewModel.delegate = self
        setUpCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
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
    
    private func setUpCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
    
    
}

extension RMEpisodeListView: RMEpisodeListViewVMDelegate {
    func didLoadMoreEpisodes(with newIndexPaths: [IndexPath]) {
        Task{
            do {
                collectionView.performBatchUpdates {
                    collectionView.insertItems(at: newIndexPaths)
                }
            }
        }
    }
    
    func didSelectEpisode(_ episode: RMEpisode) {
        delegate?.rmEpisodeList(self, didSelectEpisode: episode)
    }
    
    func didLoadInitialEpisodes() {
    
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
