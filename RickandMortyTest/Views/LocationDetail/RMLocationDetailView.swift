//
//  RMLocationDetailView.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 12/06/2024.
//

import UIKit

    
    protocol RMLocationDetailViewDelegate: AnyObject {
        func rmLocationDetailView(_ detailView: RMLocationDetailView, didSelect character: RMCharacter)
    }
    
    final class RMLocationDetailView: UIView {
        
        // MARK: - Var - Let
        
        public weak var delegate: RMLocationDetailViewDelegate?
        
        private var viewModel: RMLocationDetailViewVM? {
            didSet {
                spinner.stopAnimating()
                self.collectionView.isHidden = false
                self.collectionView.reloadData()
                UIView.animate(withDuration: 0.3) {
                    self.collectionView.alpha = 1
                }
            }
        }
        private let spinner = RMSpinner(frame: .zero)
        private var collectionView: RMLocationDetailCollectionView
        
        // MARK: - Init
        
        init(frame: CGRect, viewModel: RMLocationDetailViewVM) {
            
            self.viewModel = viewModel
            self.collectionView = RMLocationDetailCollectionView(frame: .zero, collectionViewLayout: RMLayoutCompositional(withLocation: viewModel))
            
            
            super.init(frame: frame)
            configureUI()
            spinner.startAnimating()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
        // MARK: - Public
        
        public func configure(with viewModel: RMLocationDetailViewVM) {
            self.viewModel = viewModel
            collectionView = RMLocationDetailCollectionView(frame: .zero, collectionViewLayout: RMLayoutCompositional(withLocation: viewModel))
        }
        
        
        // MARK: - Private
        
        private func configureUI() {
            translatesAutoresizingMaskIntoConstraints = false
            backgroundColor = .systemIndigo
            addSubviews(collectionView, spinner)
            addConstraints()
            collectionView.delegate = self
            collectionView.dataSource = self
            
        }
        
        private func addConstraints() {
            
            NSLayoutConstraint.activate([
                
                spinner.heightAnchor.constraint(equalToConstant: 100),
                spinner.widthAnchor.constraint(equalToConstant: 100),
                spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
                spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
                
                collectionView.topAnchor.constraint(equalTo: topAnchor),
                collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
                
            ])
            
        }
        
    }


    extension RMLocationDetailView: UICollectionViewDelegate, UICollectionViewDataSource {
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return viewModel?.cellViewModels.count ?? 0
        }
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            guard let sections = viewModel?.cellViewModels else { return 0 }
            
            let sectionType = sections[section]
            switch sectionType{
            case .information( let viewModels):
                return viewModels.count
            case .characters( let viewModels):
                print(viewModels)
                return viewModels.count
            }
            
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            guard let sections = viewModel?.cellViewModels else { fatalError("No ViewModel")}
            
            let sectionType = sections[indexPath.section]
            
            switch sectionType{
                
            case .information( let viewModels):
                let cellViewModel = viewModels[indexPath.row]
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMLocationInfoCollectionViewCell.cellIdentifier, for: indexPath) as? RMLocationInfoCollectionViewCell else { fatalError()}
                cell.configure(with: cellViewModel)
                return cell

            case .characters( let viewModels):
                let cellViewModel = viewModels[indexPath.row]
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.identifier, for: indexPath) as? RMCharacterCollectionViewCell else { fatalError()}
                cell.configure(with: cellViewModel)
                return cell
        
            }
            
            
            
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            collectionView.deselectItem(at: indexPath, animated: true)
            
            guard let viewModel = viewModel else { return }
            let sections = viewModel.cellViewModels
            
            let sectionType = sections[indexPath.section]
            
            switch sectionType{
                
            case .information:
                break
            case .characters:
                guard let character = viewModel.character(at: indexPath.row) else { return }
                delegate?.rmLocationDetailView(self, didSelect: character)
            }
            
        }
        
        
    }


