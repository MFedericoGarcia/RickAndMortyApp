//
//  Spinner.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 16/05/2024.
//

import UIKit

class RMSpinner: UIActivityIndicatorView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.style = .large
        self.hidesWhenStopped = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
