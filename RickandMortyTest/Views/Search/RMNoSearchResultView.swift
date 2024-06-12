//
//  RMNoSearchResultView.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 12/06/2024.
//

import UIKit

final class RMNoSearchResultView: UIView {
    
    private let viewModel = RMNoSearchResultViewVM()
    private let iconView = RMImageView(frame: .zero)
    private let label = RMStatusLabel(frame: .zero, fontSize: 20, weight: .medium)

    
    // MARK: - Init
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureUI() {
        
        translatesAutoresizingMaskIntoConstraints = false
        isHidden = true

        addSubviews(iconView, label)
        
        iconView.tintColor = .systemBlue
        iconView.image = viewModel.image
        label.textAlignment = .center
        label.text = viewModel.title
        
        
        NSLayoutConstraint.activate([
            
            iconView.widthAnchor.constraint(equalToConstant: 90),
            iconView.heightAnchor.constraint(equalToConstant: 90),
            iconView.topAnchor.constraint(equalTo: topAnchor),
            iconView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 10)
        ])
    }
}
