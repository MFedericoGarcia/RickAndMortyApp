//
//  RMCharacterInfoCollectionViewCell.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 27/05/2024.
//

import UIKit

final class RMCharacterInfoCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "RMCharacterInfoCollectionViewCell"
    
    private let valueLabel = RMStatusLabel(frame: .zero, title: "Earth")
    private let titleLabel = RMNameLabel(frame: .zero, title: "Location")
    private let iconImage = RMImageView(frame: .zero)
    
    private let titleContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true

        iconImage.image = UIImage(systemName: "globe.americas")
        
        contentView.addSubviews(titleContainer, valueLabel, iconImage)
        titleContainer.addSubview(titleLabel)
        setUpConstraints()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setUpConstraints() {
        titleLabel.textAlignment = .center
        valueLabel.numberOfLines = 3
        
        NSLayoutConstraint.activate([
            
            titleContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleContainer.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.33),
            
            titleLabel.leadingAnchor.constraint(equalTo: titleContainer.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: titleContainer.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: titleContainer.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleContainer.bottomAnchor),
            
            iconImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            iconImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            iconImage.heightAnchor.constraint(equalToConstant: 50),
            iconImage.widthAnchor.constraint(equalToConstant: 50),
            
            valueLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 10),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            valueLabel.centerYAnchor.constraint(equalTo: iconImage.centerYAnchor),
                        

        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        valueLabel.text = nil
        iconImage.image = nil
        iconImage.tintColor = .label
        titleLabel.tintColor = .label
    }
    
    public func configure(with viewModel: RMCharacterInfoCollectionViewCellVM) {
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.displayValue
        iconImage.image = viewModel.iconImage
        iconImage.tintColor = viewModel.tintColor
        titleLabel.tintColor = viewModel.tintColor
    }
}
