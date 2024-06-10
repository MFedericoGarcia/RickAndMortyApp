//
//  RMSearchVC.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 30/05/2024.
//

import UIKit


// Configuracion para la barra de busqueda
class RMSearchVC: UIViewController {
    
    struct Config {
        enum `Type` {
            case character
            case episode
            case location
        }
        let type: `Type`
    }

    private let config: Config
    
    init(config: Config) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        view.backgroundColor = .systemBackground
    }
    

}
