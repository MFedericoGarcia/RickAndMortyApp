//
//  RMLocationVC.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 15/05/2024.
//

import UIKit



final class RMLocationVC: UIViewController, RMLocationViewVMDelegate, RMLocationViewDelegate {
    
    
    
    private let primaryView = RMLocationView(frame: .zero)
    private let viewModel = RMLocationViewVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addConstraints()
        addSearchButton()
        viewModel.delegate = self
        viewModel.fetchLocations()
    }
    
    private func configure() {
        primaryView.delegate = self
        view.addSubviews(primaryView)
        view.backgroundColor = .systemBackground
        title = "Location"
    }
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    private func addConstraints() {
        
        NSLayoutConstraint.activate([
            primaryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            primaryView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            primaryView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            primaryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    @objc func didTapSearch() {
        let vc = RMSearchVC(config: RMSearchVC.Config(type: .location))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - LocationView Delegate
    
    func rmLocationView(_ locationView: RMLocationView, didSelect location: RMLocation) {
        let vc = RMLocationDetailVC(location: location)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - LocationVM Delegate
    
    func didFetchInitialLocations() {
        primaryView.configure(with: viewModel)
    }
}


