//
//  GFSecondaryTitleLabel.swift
//  GithubFollowers
//
//  Created by Yaşar Duman on 5.10.2023.
//

import UIKit

final class SecondaryTitleLabel: UILabel {
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    // MARK: - Configuration
    private func configure() {
        textColor                                 = .secondaryLabel
        adjustsFontForContentSizeCategory         = true
        adjustsFontSizeToFitWidth                 = true
        minimumScaleFactor                        = 0.90
        lineBreakMode                             = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
