//
//  RMLocationTableView.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 10/06/2024.
//

import UIKit

class RMLocationTableView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .grouped)
        translatesAutoresizingMaskIntoConstraints = false
        register(RMLocationTableViewCell.self, forCellReuseIdentifier: RMLocationTableViewCell.cellIdentifier)
        isHidden = true
        alpha = 0
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
