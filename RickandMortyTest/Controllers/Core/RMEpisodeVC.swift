//
//  RMEpisodeVC.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 15/05/2024.
//

import UIKit

final class RMEpisodeVC: UIViewController, RMEpisodeListViewDelegate {

    private let episodeListView = RMEpisodeListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureEpisodeListView()
        addSearchButton()
        navigationItem.largeTitleDisplayMode = .automatic
    }
    
    private func configure() {
        view.backgroundColor = .systemBackground
        title = "Episodes"
    }
    
    
    
    private func configureEpisodeListView() {
        episodeListView.delegate = self
        view.addSubviews(episodeListView)
        
        NSLayoutConstraint.activate([
            episodeListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            episodeListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            episodeListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            episodeListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func rmEpisodeList(_ characterListView: RMEpisodeListView, didSelectEpisode episode: RMEpisode) {
        let detailVC = RMEpisodeDetailVC(url: URL(string: episode.url))
        detailVC.navigationItem.largeTitleDisplayMode = .never
        
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    @objc func didTapSearch() {
        let vc = RMSearchVC(config: RMSearchVC.Config(type: .episode))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
