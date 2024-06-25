//
//  RMSearchButton.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 14/06/2024.
//

import UIKit

class RMSearchButton: UIButton {
    
    private let option: RMSearchInputViewVM.DynamicOption?

    
    init(frame: CGRect, with option: RMSearchInputViewVM.DynamicOption, tag: Int) {
        self.option = option
        super.init(frame: frame)
        self.tag = tag
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        guard let option = option else { return }
        setAttributedTitle(
            NSAttributedString(
            string: option.rawValue,
            attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium), .foregroundColor: UIColor.label ]),
                                  for: .normal)
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 6
        
        
    }
}
