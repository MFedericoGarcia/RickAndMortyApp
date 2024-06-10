//
//  RMLocationView.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 10/06/2024.
//

import UIKit

final class RMLocationView: UIView {
    
    let tableView = RMLocationTableView(frame: .zero, style: .plain)
    let spinner = RMSpinner(frame: .zero)
    
    private var viewModel: RMLocationViewVM? {
        didSet {
            spinner.stopAnimating()
            tableView.isHidden = false
            tableView.reloadData()
            UIView.animate(withDuration: 0.3) {
                self.tableView.alpha = 1
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemRed
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(tableView, spinner)
        addConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addConstraints() {
        spinner.startAnimating()
        NSLayoutConstraint.activate([
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    public func configure( with viewModel: RMLocationViewVM) {
        self.viewModel = viewModel
    }
   
}
