//
//  RMSettingsCellVM.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 06/06/2024.
//

import UIKit

struct RMSettingsCellVM: Identifiable {
    
    let id = UUID()

    public let type: RMSettingsOption
    public let onTapHandler: (RMSettingsOption) -> Void
    
    // MARK: - Init
    
    init(type: RMSettingsOption, onTapHandler: @escaping (RMSettingsOption) -> Void) {
        self.type = type
        self.onTapHandler = onTapHandler
    }
    
    // MARK: - Public
    
    public var image: UIImage? { return type.iconImage }
    public var title: String { return type.displayTitle }
    public var iconContainer: UIColor { return type.iconContainerColor}
    
}
