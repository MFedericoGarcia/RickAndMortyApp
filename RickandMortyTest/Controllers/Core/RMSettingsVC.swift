//
//  RMSettingsVC.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 15/05/2024.
//

import UIKit

/// Controller que muestra varias opciones de la app y configuraciones
final class RMSettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .systemBackground
        title = "Settings"
    }

}
