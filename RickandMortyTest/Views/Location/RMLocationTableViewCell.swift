//
//  RMLocationTableViewCell.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 11/06/2024.
//

import UIKit

class RMLocationTableViewCell: UITableViewCell {

    static let cellIdentifier = "RMLocationTableViewCell"
    
    
    // MARK: - Components
    
    private let nameLabel = RMNameLabel(frame: .zero)
    private let dimensionLabel = RMStatusLabel(frame: .zero, fontSize: 15, weight: .regular)
    private let typeLabel = RMStatusLabel(frame: .zero, fontSize: 15, weight: .light)
    
    // MARK: - INIT
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(nameLabel, dimensionLabel, typeLabel)
        accessoryType = .disclosureIndicator
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = nil
        dimensionLabel.text = nil
        typeLabel.text = nil
    }
    
    
    // MARK: - Private
    
    private func addConstraints() {
        
        NSLayoutConstraint.activate([
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            typeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            typeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            typeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            dimensionLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 10),
            dimensionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            dimensionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            dimensionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
            
        ])
        
    }
    
    
    // MARK: - Public
    
    public func configure(with viewModel: RMLocationTableViewCellVM) {
        nameLabel.text = viewModel.name
        dimensionLabel.text = viewModel.dimension
        typeLabel.text = viewModel.type
        
        nameLabel.textAlignment = .left
        dimensionLabel.textAlignment = .left
        typeLabel.textAlignment = .left
        
        dimensionLabel.textColor = .secondaryLabel
        typeLabel.textColor = .secondaryLabel
    }
    
    

}
