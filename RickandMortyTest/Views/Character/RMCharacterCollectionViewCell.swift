//
//  RMCharacterCollectionViewCell.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 17/05/2024.
//

import UIKit

/// Cell para Character
final class RMCharacterCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RMCharacterCollectionViewCell"
    private let nameLabel = RMNameLabel(frame: .zero)
    private let statusLabel = RMStatusLabel(frame: .zero)
    private let imageView = RMImageView(frame: .zero)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(imageView, nameLabel, statusLabel)
        configureCellConstraints()
        configureContentViewUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureContentViewUI() {
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = UIColor.secondaryLabel.cgColor
        contentView.layer.shadowOffset = CGSize(width: -4, height: 4)
        contentView.layer.shadowOpacity = 0.4
        contentView.layer.masksToBounds = true
        
    }
    
    private func configureCellConstraints() {
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            statusLabel.heightAnchor.constraint(equalToConstant: 30),
            statusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            statusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            nameLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor, constant: -3),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -3),

        ])
        
    }
        
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
        statusLabel.text = nil
    }
    
    public func configure(with viewModel: RMCharacterCollectionViewCellVM) {
        let image = UIImage()
        Task {
            do{
                imageView.image = UIImage(data: try await viewModel.fetchImage()) ?? UIImage()
            } catch {
                throw URLError(.cannotMoveFile)
            }
        }
        
        
        
        imageView.image = image
        nameLabel.text = viewModel.characterName
        statusLabel.text = viewModel.characterStatusText
        
    }
}
