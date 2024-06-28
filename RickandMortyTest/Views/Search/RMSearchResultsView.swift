//
//  RMSearchResultsView.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 26/06/2024.
//

import UIKit

protocol RMSearchResultsViewDelegate: AnyObject {
    func rmSearchResultsView(_ resultsView: RMSearchResultsView, didTapLocationAt index: Int)
}

/// Search collection UI
final class RMSearchResultsView: UIView {
    
    weak var delegate: RMSearchResultsViewDelegate?
    
    private var viewModel: RMSearchResultVM? {
        didSet {
            self.processViewModel()
        }
    }
    
    private let tableView = RMLocationTableView(frame: .zero, style: .plain)
    private let collectionView = RMCharacterListCollectionView(frame: .zero)
    
    private var locationCellVMs: [RMLocationTableViewCellVM] = []
    private var collectionViewCellVMs: [any Hashable] = []
    
    
//    MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isHidden = true
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(tableView, collectionView)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
//    MARK: - Private Funcs
    
    private func processViewModel() {
        guard let viewModel = viewModel else { return }
        
        switch viewModel {
        case .characters(let viewModels):
            self.collectionViewCellVMs = viewModels
            setUpCollectionView()
        case .episodes(let viewModels):
            self.collectionViewCellVMs = viewModels
            setUpCollectionView()
        case .location(let viewModels):
            setUpTableView(viewModels: viewModels)
        }
    }
    
    private func setUpCollectionView() {
        collectionView.isHidden = false
        tableView.isHidden = true
        collectionView.alpha = 1
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }

    private func setUpTableView(viewModels: [RMLocationTableViewCellVM]) {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = false
        collectionView.isHidden = true
        tableView.alpha = 1
        self.locationCellVMs = viewModels
        tableView.reloadData()
    }
    
    private func addConstraints(){
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
//    MARK: - Public Funcs
    
    public func configure(with viewModel: RMSearchResultVM) {
        self.viewModel = viewModel
    }
    
}

// MARK: - TableView Delegate / DataSource

extension RMSearchResultsView: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return locationCellVMs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RMLocationTableViewCell.cellIdentifier, for: indexPath) as? RMLocationTableViewCell else {
            fatalError()
        }
        cell.configure(with: locationCellVMs[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.rmSearchResultsView(self, didTapLocationAt: indexPath.row)
        
    }
}

extension RMSearchResultsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewCellVMs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentVM = collectionViewCellVMs[indexPath.row]
        
        if currentVM is RMCharacterCollectionViewCellVM {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.identifier, for: indexPath) as? RMCharacterCollectionViewCell else {
                fatalError()
            }
            
            if let characterVM = currentVM as? RMCharacterCollectionViewCellVM {
                cell.configure(with: characterVM )
            }
            return cell

            
        }
        
        
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterEpisodeCollectionViewCell.cellIdentifier, for: indexPath) as? RMCharacterEpisodeCollectionViewCell else {
                fatalError()
            }
            
            if let episodeVM = currentVM as? RMCharacterEpisodeCollectionViewCellVM {
                cell.configure(with: episodeVM)
            }
            return cell

        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true   )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let currentVM = collectionViewCellVMs[indexPath.row]

        let bounds = collectionView.bounds
        
        // CHARACTER SIZE
        if currentVM is RMCharacterCollectionViewCellVM {
            let width = ( bounds.width - 30) / 2
            return CGSize(width: width, height: width * 1.5)
        }
        // EPISODE SIZE
        let width = bounds.width - 20
        return CGSize(width: width, height: 100)
        
    }
}
