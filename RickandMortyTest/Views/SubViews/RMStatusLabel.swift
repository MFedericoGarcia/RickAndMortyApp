//
//  RMStatusLabel.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 17/05/2024.
//

import UIKit

class RMStatusLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = .secondaryLabel
        font = .systemFont(ofSize: 16, weight: .regular)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
