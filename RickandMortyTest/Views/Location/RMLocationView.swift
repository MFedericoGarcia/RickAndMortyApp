//
//  RMLocationView.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 10/06/2024.
//

import UIKit

protocol RMLocationViewDelegate: AnyObject {
    func rmLocationView( _ locationView: RMLocationView, didSelect location: RMLocation )
}

final class RMLocationView: UIView {
    
    public weak var delegate: RMLocationViewDelegate?
    
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
        configureTable()
        
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
    
    private func configureTable() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    public func configure( with viewModel: RMLocationViewVM) {
        self.viewModel = viewModel
    }
   
}

extension RMLocationView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let locationModel = viewModel?.location(at: indexPath.row) else {
            return
        }
        delegate?.rmLocationView(self, didSelect: locationModel)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cellViewModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cellVMs = viewModel?.cellViewModels else { fatalError() }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RMLocationTableViewCell.cellIdentifier, for: indexPath) as? RMLocationTableViewCell else {
            fatalError()
        }
        let cellVM = cellVMs[indexPath.row]
        
        cell.configure(with: cellVM)
        
//        var config = cell.defaultContentConfiguration()
//        config.text = cellVM.name
//        cell.contentConfiguration = config
        
        
        return cell
    }
    
    
}
