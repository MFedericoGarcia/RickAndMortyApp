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
        enum tipo {
            case character
            case episode
            case location
            
            var endpoint: RMEndPoint {
                switch self {
                case .character:
                    return .character
                case .episode:
                    return .episode
                case .location:
                    return .location
                }
            }
            
            
            var title: String {
                switch self {
                
                case .character:
                    return "Searching Character"
                case .episode:
                    return "Searching Episode"
                case .location:
                    return "Searching Location"
                }
            }
        }
        let type: tipo
    }
    private let viewModel: RMSearchViewVM
    private let searchView: RMSearchView
    
    // MARK: - Init
    
    init(config: Config) {
        let viewModel = RMSearchViewVM(config: config)
        self.viewModel = viewModel
        self.searchView = RMSearchView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .done, target: self, action: #selector(didTapExecuteSearch))
        searchView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchView.presentKeyboard()
    }
    
    // MARK: - Private Funcs
    
    private func configureUI() {
        title = viewModel.config.type.title
        view.backgroundColor = .systemBackground
        view.addSubviews(searchView)
        
        NSLayoutConstraint.activate([
            searchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
        ])
    }
    
    @objc private func didTapExecuteSearch() {
        viewModel.executeSearch()
    }
    
    
    

}

// MARK: - RMSearchViewDelegate

extension RMSearchVC: RMSearchViewDelegate {
    func rmSearchView(_ searchView: RMSearchView, didSelectOption option: RMSearchInputViewVM.DynamicOption) {
        let vc = RMSearchOptionVC(option: option) {[weak self]selection in
            DispatchQueue.main.async {
                self?.viewModel.set(value: selection, for: option)
            }
        }
        vc.sheetPresentationController?.detents = [.medium()]
        vc.sheetPresentationController?.prefersGrabberVisible = true
        present(vc, animated: true)
    }
    
    
}
