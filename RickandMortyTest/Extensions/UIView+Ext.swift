//
//  UIView+Ext.swift
//  RickandMortyTest
//
//  Created by Fede Garcia on 16/05/2024.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view)}
    }
}
