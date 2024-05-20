//
//  RMImageView.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 17/05/2024.
//

import UIKit

class RMImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
