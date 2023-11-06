//
//  UIView+Ext.swift
//  Movie-App
//
//  Created by Yaşar Duman on 30.10.2023.
//


import UIKit

extension UIView{
    
    // MARK: - Adding Subviews
    func addSubviewsExt(_ views: UIView...) {
        for view in views { addSubview(view)}
    }
    
    // MARK: - Auto Layout Constraints
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, padding: UIEdgeInsets = .zero, size: CGSize = .zero) -> AnchoredConstraints {
        // Set translatesAutoresizingMaskIntoConstraints to false for auto layout
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchoredConstraints = AnchoredConstraints()
        
        // MARK: - Top Anchor
        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        // MARK: - Leading Anchor
        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        // MARK: - Bottom Anchor
        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        // MARK: - Trailing Anchor
        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right )
        }
        
        // MARK: - Width Anchor
        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        
        // MARK: - Height Anchor
        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        
        // Activate constraints
        [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing, anchoredConstraints.width, anchoredConstraints.height].forEach { $0?.isActive = true }
        
        return anchoredConstraints
    }
    
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        // Set translatesAutoresizingMaskIntoConstraints to false for auto layout
        translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: - Top Anchor
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
        }
        
        // MARK: - Bottom Anchor
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
        }
        
        // MARK: - Leading Anchor
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
        }
        
        // MARK: - Trailing Anchor
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
        }
    }
    
    func centerInSuperview(size: CGSize = .zero) {
        // Set translatesAutoresizingMaskIntoConstraints to false for auto layout
        translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: - Center X Anchor
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
        
        // MARK: - Center Y Anchor
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
        
        // MARK: - Width Anchor
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        // MARK: - Height Anchor
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    // MARK: - Center in Superview
    func centerXInSuperview() {
        // Set translatesAutoresizingMaskIntoConstraints to false for auto layout
        translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: - Center X Anchor
        if let superViewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superViewCenterXAnchor).isActive = true
        }
    }
    
    func centerYInSuperview() {
        // Set translatesAutoresizingMaskIntoConstraints to false for auto layout
        translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: - Center Y Anchor
        if let centerY = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
        
        func constrainWidth(constant: CGFloat) {
            // Set translatesAutoresizingMaskIntoConstraints to false for auto layout
            translatesAutoresizingMaskIntoConstraints = false
            
            // MARK: - Width Anchor
            widthAnchor.constraint(equalToConstant: constant).isActive = true
        }
        
        func constrainHeight(constant: CGFloat) {
            // Set translates to false for auto layout
            translatesAutoresizingMaskIntoConstraints = false
            
            // MARK: - Height Anchor
            heightAnchor.constraint(equalToConstant: constant).isActive = true
        }
    }
    
    /// A structure that holds Auto Layout constraints for anchoring views.
    struct AnchoredConstraints {
        var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
    }
    
    
}
