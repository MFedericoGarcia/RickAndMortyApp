//
//  RMSearchViewVM.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 12/06/2024.
//

import Foundation

final class RMSearchViewVM {
    
    let config: RMSearchVC.Config
    private var oprionMap: [RMSearchInputViewVM.DynamicOption: String] = [:]
    private var searchText = ""
    
    private var optionMapUpdateBlock: (((RMSearchInputViewVM.DynamicOption, String)) -> Void)?
    
   
    
    // MARK: - Init
    
    init(config: RMSearchVC.Config) {
        self.config = config
    }
    
    // MARK: - Public
    
    public func set(value: String, for option: RMSearchInputViewVM.DynamicOption) {
        oprionMap[option] = value
        let tuple = (option, value)
        optionMapUpdateBlock?(tuple)
    }
    
    public func set(query text: String) {
        self.searchText = text
    }
    
    public func registerOptionChangeBlock(_ block: @escaping((RMSearchInputViewVM.DynamicOption, String)) -> Void) {
        self.optionMapUpdateBlock = block
    }
}
