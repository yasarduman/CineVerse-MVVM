//
//  GFButton.swift
//  GithubFollowers
//
//  Created by Yaşar Duman on 4.10.2023.
//

import UIKit

class MovieButton: UIButton {
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(color: UIColor, title: String, systemImageName: String){
        self.init(frame: .zero)
        set(color: color, title: title, systemImageName: systemImageName)
    }
    
    // MARK: - Configuration
    private func configure() {
        configuration = .tinted()
        configuration?.cornerStyle = .medium
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(color: UIColor, title: String, systemImageName: String) {
        configuration?.baseBackgroundColor = color
        configuration?.baseForegroundColor = color
        configuration?.title = title
        configuration?.contentInsets.leading = -10
        configuration?.image = UIImage(systemName: systemImageName)
        configuration?.imagePadding = 6
    
    
    }
    
}
