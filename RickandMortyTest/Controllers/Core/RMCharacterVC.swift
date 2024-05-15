//
//  RMCharacterVC.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 15/05/2024.
//

import UIKit

final class RMCharacterVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .systemBackground
        title = "Characters"
    }

}
