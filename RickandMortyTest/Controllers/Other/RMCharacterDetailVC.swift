//
//  RMCharacterDetailVC.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 20/05/2024.
//

import UIKit

class RMCharacterDetailVC: UIViewController {
    
    private var viewModel: RMCharacterDetailViewVM
    
    init(viewModel: RMCharacterDetailViewVM){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
    }
    
}
