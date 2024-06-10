//
//  RMLocationVC.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 15/05/2024.
//

import UIKit

final class RMLocationVC: UIViewController {

    private let primaryView = RMLocationView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addConstraints()
        addSearchButton()
    }
    
    private func configure() {
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
        
    }

}
