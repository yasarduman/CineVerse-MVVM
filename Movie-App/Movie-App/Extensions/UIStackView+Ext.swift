//
//  UIStackView+Ext.swift
//  Movie-App
//
//  Created by Yaşar Duman on 30.10.2023.
//


import UIKit

extension UIStackView {
    // MARK: - Adding Arranged Subviews
    func addArrangedSubviewsExt(_ views: UIView...) {
        for view in views { addArrangedSubview(view) }
    }
}
