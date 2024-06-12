//
//  RMLocationDetailVC.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 12/06/2024.
//

import UIKit

final class RMLocationDetailVC: UIViewController, RMLocationDetailViewVMDelegate, RMLocationDetailViewDelegate {
    
    
   
    
    
    private let viewModel: RMLocationDetailViewVM
    private let detailView: RMLocationDetailView
    
    init(location: RMLocation) {
        let url = URL(string: location.url)
        self.viewModel = RMLocationDetailViewVM(endpointUrl: url)
        self.detailView = RMLocationDetailView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Location"
        
        configureUI()
        addSearchButton()
        detailView.delegate = self
        viewModel.delegate = self
        viewModel.fetchLocationData()
    }
    
    private func configureUI() {
        view.addSubview(detailView)
        
        
        
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    @objc func didTapSearch() {
        
    }
    
   
    func rmLocationDetailView(_ detailView: RMLocationDetailView, didSelect character: RMCharacter) {
        let vc = RMCharacterDetailVC(viewModel: .init(character: character))
        vc.title = character.name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Delegate
    
    func
    didFetchLocationDetails() {
        Task {
            detailView.configure(with: viewModel)
        }
    }
  
}
