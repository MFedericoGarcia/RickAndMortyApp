//
//  RMSettingsVC.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 15/05/2024.
//

import StoreKit
import UIKit
import SwiftUI
import SafariServices

/// Controller que muestra varias opciones de la app y configuraciones
final class RMSettingsVC: UIViewController {
    
    private let viewModel = RMSettingsViewVM(cellViewModels: RMSettingsOption.allCases.compactMap({ optionVM in
        return RMSettingsCellVM(type: optionVM) { option in
            
        }
    }))
    
    private var settingsSwiftUIController: UIHostingController<RMSettingsView>?

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .systemBackground
        title = "Settings"
        addSwiftUIController()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func addSwiftUIController() {
        
        let settingsSwiftUIController = UIHostingController(rootView: RMSettingsView(viewModel: RMSettingsViewVM(cellViewModels: RMSettingsOption.allCases.compactMap({
            return RMSettingsCellVM(type: $0) { [weak self]option in
                self?.handleTap(option: option)
            }
        }))))
        
    
        addChild(settingsSwiftUIController)
        settingsSwiftUIController.didMove(toParent: self)
        
        view.addSubview(settingsSwiftUIController.view)
        settingsSwiftUIController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            settingsSwiftUIController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsSwiftUIController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            settingsSwiftUIController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            settingsSwiftUIController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func handleTap(option: RMSettingsOption) {
        guard Thread.current.isMainThread else {
            return
        }
        
        if let url = option.targetUrl {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        } else if option == .rateApp {
            // Show rate
            
            if let windowScene = view.window?.windowScene {
                SKStoreReviewController.requestReview(in: windowScene)
            }
        }
        
    }

}
