//
//  RMSettingsOption.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 06/06/2024.
//

import UIKit

enum RMSettingsOption: CaseIterable {
    case rateApp
    case contactUs
    case terms
    case privacy
    case apiReference
    case viewSeries
    case viewCode
    
    var targetUrl: URL? {
        switch self {
        case .rateApp:
            return nil
        case .contactUs:
            return URL(string: "https://iosacademy.io/")
        case .terms:
            return URL(string: "https://iosacademy.io/terms")
        case .privacy:
            return URL(string: "https://iosacademy.io/privacy")
        case .apiReference:
            return URL(string: "https://rickandmortyapi.com/documentation/#get-a-single-episode")
        case .viewSeries:
            return URL(string: "https://www.youtube.com/watch?v=nTAQimLSQgA&ab_channel=AdultSwimLA")
        case .viewCode:
            return URL(string: "https://github.com/MFedericoGarcia/RickAndMortyApp")
        }
    }
    
    var displayTitle: String {
        switch self {
        case .rateApp:
            return "Rate App"
        case .contactUs:
            return "Contact us"
        case .terms:
            return "Terms of Service"
        case .privacy:
            return "Privacy policy"
        case .apiReference:
            return "API Reference"
        case .viewSeries:
            return "View Video Series"
        case .viewCode:
            return "View App Code"
        }
    }
    
    var iconContainerColor: UIColor {
        switch self {
        case .rateApp:
            return .systemGreen
        case .contactUs:
            return .systemBlue
        case .terms:
            return .systemRed
        case .privacy:
            return .systemYellow
        case .apiReference:
            return .systemOrange
        case .viewSeries:
            return .systemPurple
        case .viewCode:
            return .systemPink
        }
    }
    
    var iconImage: UIImage? {
        switch self {
        case .rateApp:
            return SFSymbols.star
        case .contactUs:
            return SFSymbols.contactUs
        case .terms:
            return SFSymbols.terms
        case .privacy:
            return SFSymbols.privacy
        case .apiReference:
            return SFSymbols.apiReference
        case .viewSeries:
            return SFSymbols.viewSeries
        case .viewCode:
            return SFSymbols.viewCode
        }
    }
}
