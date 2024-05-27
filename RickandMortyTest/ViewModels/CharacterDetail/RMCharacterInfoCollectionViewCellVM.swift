//
//  RMCharacterInfoCollectionViewCellVM.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 27/05/2024.
//

import UIKit

final class RMCharacterInfoCollectionViewCellVM {
    private var value: String
    private let type: `Type`
    
    var dateFormatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        return formatter
    }()
        
    public var title: String {
        type.displayTitle
    }
    
    public var displayValue: String {
        if value.isEmpty {return "None"}
        
        if let date = self.dateFormatter.date(from: value), type == .created {
            value = date.convertToMonthYearFormat()
            return value
        }
        
        return value
    }
    
    public var iconImage: UIImage? {
        
        return type.iconImage
    }
    
    public var tintColor: UIColor {
        return type.tintColor
    }
    
    
    
    enum `Type`: String {
        case status
        case gender
        case type
        case species
        case origin
        case created
        case location
        case episodeCount
        
        var tintColor: UIColor {
            switch self {
            case .status:
                return .systemRed
            case .gender:
                return .systemGray
            case .type:
                return .systemPurple
            case .species:
                return .systemGreen
            case .origin:
                return .systemOrange
            case .created:
                return .systemPink
            case .location:
                return .systemYellow
            case .episodeCount:
                return .systemMint
            }
        }
        
        var iconImage: UIImage? {
            switch self {
            case .status:
                return UIImage(systemName: "staroflife.fill")
            case .gender:
                return UIImage(systemName: "person.text.rectangle")
            case .type:
                return UIImage(systemName: "timelapse")
            case .species:
                return UIImage(systemName: "person.fill.questionmark")
            case .origin:
                return UIImage(systemName: "globe.americas")
            case .created:
                return UIImage(systemName: "calendar")
            case .location:
                return UIImage(systemName: "mappin.and.ellipse.circle.fill")
            case .episodeCount:
                return UIImage(systemName: "list.number")
            }
        }
        
        var displayTitle: String {
            switch self {
            case .status,
                .gender,
                .type,
                .species,
                .origin,
                .created,
                .location:
                return rawValue.uppercased()
            
            case .episodeCount:
                return "EPISODE COUNT"
            }
        }
    }
    
    init(value: String, type: `Type` ) {
        self.value = value
        self.type = type
    }
    
  
}
