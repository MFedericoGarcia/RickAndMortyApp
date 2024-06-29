//
//  RMTableLoadingFooterView.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 29/06/2024.
//

import UIKit

final class RMTableLoadingFooterView: UIView {

    private let spinner = RMSpinner(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configure(){
        addSubviews(spinner)
        spinner.startAnimating()
        
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 55),
            spinner.heightAnchor.constraint(equalToConstant: 55),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    
}
