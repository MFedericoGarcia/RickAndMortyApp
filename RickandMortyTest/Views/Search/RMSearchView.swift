//
//  RMSearchView.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 12/06/2024.
//

import UIKit

protocol RMSearchViewDelegate: AnyObject {
    func rmSearchView(_ searchView: RMSearchView, didSelectOption option: RMSearchInputViewVM.DynamicOption)
}

final class RMSearchView: UIView {
    
    weak var delegate: RMSearchViewDelegate?
    
    private let viewModel: RMSearchViewVM
    
    // MARK: - Subviews
    
    
    // SearchInputView
    private let searchInputView = RMSearchInputView(frame: .zero)
    
    
    private let noResultsView = RMNoSearchResultView()
    
    // MARK: - Init
    
    init(frame: CGRect, viewModel: RMSearchViewVM) {
        
        self.viewModel = viewModel
        super.init(frame: frame)
        
        configureUI()
        searchInputView.configure(with: RMSearchInputViewVM(type: viewModel.config.type))
        searchInputView.delegate = self
        
        viewModel.registerOptionChangeBlock { tuple in
            self.searchInputView.update(option: tuple.0, value: tuple.1)
        }
        
        viewModel.registerSearchResoultHandler{ results in
            print(results)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    private func configureUI() {
        
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(noResultsView, searchInputView)
        
        NSLayoutConstraint.activate([
            // Search Input View
            searchInputView.topAnchor.constraint(equalTo: topAnchor),
            searchInputView.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchInputView.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchInputView.heightAnchor.constraint(equalToConstant: viewModel.config.type == .episode ? 55 : 110),
            
            
            // No Results
            noResultsView.widthAnchor.constraint(equalToConstant: 150),
            noResultsView.heightAnchor.constraint(equalToConstant: 150),
            noResultsView.centerXAnchor.constraint(equalTo: centerXAnchor),
            noResultsView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    public func presentKeyboard() {
        searchInputView.presentKeyboard()
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

extension RMSearchView: RMSearchInputViewDelegate {
    func rmSearchInputViewDidTapSearchKeyboardButton(_ inputView: RMSearchInputView) {
        viewModel.executeSearch()
    }
    
    func rmSearchInputView(_ inputView: RMSearchInputView, didChancheSearchText text: String) {
        viewModel.set(query: text)
    }
    
    func rmSearchInputView(_ inputView: RMSearchInputView, didselectOption option: RMSearchInputViewVM.DynamicOption) {
        delegate?.rmSearchView(self, didSelectOption: option)
    }
    
    
}
