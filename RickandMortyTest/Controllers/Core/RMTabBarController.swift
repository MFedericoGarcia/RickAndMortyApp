//
//  ViewController.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 15/05/2024.
//

import UIKit

/// Controller que administra las pestañas y sus respectivas Views
class RMTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpTabs()
    }
    
    private func setUpTabs() {
        
        let characterVC = RMCharacterVC()
        let locationVC = RMLocationVC()
        let episodeVC = RMEpisodeVC()
        let settingsVC = RMSettingsVC()
        
        characterVC.navigationItem.largeTitleDisplayMode = .automatic
        locationVC.navigationItem.largeTitleDisplayMode = .automatic
        episodeVC.navigationItem.largeTitleDisplayMode = .automatic
        settingsVC.navigationItem.largeTitleDisplayMode = .automatic
        
        let tab1 = UINavigationController(rootViewController: characterVC)
        let tab2 = UINavigationController(rootViewController: locationVC)
        let tab3 = UINavigationController(rootViewController: episodeVC)
        let tab4 = UINavigationController(rootViewController: settingsVC)
        
        tab1.tabBarItem = UITabBarItem(title: "Characters", image: SFSymbols.character, tag: 1)
        tab2.tabBarItem = UITabBarItem(title: "Locations", image: SFSymbols.location, tag: 2)
        tab3.tabBarItem = UITabBarItem(title: "Episodes", image: SFSymbols.episode, tag: 3)
        tab4.tabBarItem = UITabBarItem(title: "Settings", image: SFSymbols.settings, tag: 4)

        
        for tab in [tab1, tab2, tab3, tab4] {
            tab.navigationBar.prefersLargeTitles = true
        }
        
        
        setViewControllers([tab1, tab2, tab3, tab4], animated: true)
        
    }
    


}

