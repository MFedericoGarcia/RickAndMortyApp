//
//  RMSearchResultsView.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 26/06/2024.
//

import UIKit

/// Seearch collection UI
final class RMSearchResultsView: UIView {
    
    private var viewModel: RMSearchResultVM? {
        didSet {
            self.processViewModel()
        }
    }
    
    private let tableView = RMLocationTableView(frame: .zero, style: .plain)
    
    
//    MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isHidden = true
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(tableView)
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
            setUpCollectionView()
        case .episodes(let viewModels):
            setUpCollectionView()
        case .location(let viewModels):
            setUpTableView()
        }
    }
    
    private func setUpCollectionView() {
        
    }

    private func setUpTableView() {
        print("ACA ANDA")
        tableView.isHidden = false
        tableView.alpha = 1
    }
    
    private func addConstraints(){
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
//    MARK: - Public Funcs
    
    public func configure(with viewModel: RMSearchResultVM) {
        self.viewModel = viewModel
    }
    
}
