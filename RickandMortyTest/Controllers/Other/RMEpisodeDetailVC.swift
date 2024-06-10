//
//  RMEpisodeDetailVC.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 29/05/2024.
//

import UIKit

class RMEpisodeDetailVC: UIViewController, RMEpisodeDetailViewVMDelegate, RMEpisodeDetailViewDelegate {

    private let viewModel: RMEpisodeDetailViewVM
    private let detailView: RMEpisodeDetailView
    
    init(url: URL?) {
        self.viewModel = RMEpisodeDetailViewVM(endpointUrl: url)
        self.detailView = RMEpisodeDetailView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episode"
        
        configureUI()
        addSearchButton()
        detailView.delegate = self
        viewModel.delegate = self
        viewModel.fetchEpisodeData()
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
    
    func rmEpisodeDetailView(_ detailView: RMEpisodeDetailView, didSelect character: RMCharacter) {
        let vc = RMCharacterDetailVC(viewModel: .init(character: character))
        vc.title = character.name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Delegate
    
    func 
    didFetchEpisodeDetails() {
        Task {
            detailView.configure(with: viewModel)
        }
    }
    
}
