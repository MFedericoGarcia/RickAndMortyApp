//
//  RMEpisodeInfoCollectionViewCell.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 31/05/2024.
//

import UIKit

class RMEpisodeInfoCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "RMEpisodeInfoCollectionViewCell"
    
    
    private let titleLabel = RMStatusLabel(frame: .zero, title: "", fontSize: 20, weight: .medium)
    private let valueLabel = RMStatusLabel(frame: .zero, title: "", fontSize: 20, weight: .regular)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        setUpLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLayer() {
        layer.cornerRadius = 8
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.secondaryLabel.cgColor
        valueLabel.textAlignment = .right
        addConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        valueLabel.text = nil
    }
    
    private func addConstraints() {
        contentView.addSubviews(titleLabel, valueLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.47),
            
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            valueLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.47)
        ])
    }
    
    public func configure(with viewModel: RMEpisodeInfoCollectionViewCellVM) {
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.value
    }
}
