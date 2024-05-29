//
//  RMStatusLabel.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 17/05/2024.
//

import UIKit

class RMStatusLabel: UILabel {

    init(frame: CGRect, title: String = "", fontSize: CGFloat = 16, weight: UIFont.Weight = .regular ) {
        super.init(frame: frame)
        textColor = .secondaryLabel
        text = title
        font = .systemFont(ofSize: fontSize, weight: weight)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
