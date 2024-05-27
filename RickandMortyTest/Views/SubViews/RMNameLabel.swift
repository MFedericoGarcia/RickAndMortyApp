//
//  RMLabel.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 17/05/2024.
//

import UIKit

class RMNameLabel: UILabel {

    init(frame: CGRect, title: String = "") {
        super.init(frame: frame)
        textColor = .label
        font = .systemFont(ofSize: 18, weight: .medium)
        self.text = title
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
