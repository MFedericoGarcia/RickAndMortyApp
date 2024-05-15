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
        
        let request = RMRequest(endpoint: .character, queryParameters: [URLQueryItem(name: "name", value: "rick"),
                                                                       URLQueryItem(name: "status", value: "alive")])
        
        print(request.url)
    }

}
