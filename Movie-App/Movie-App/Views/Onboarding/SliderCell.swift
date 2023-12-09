//
//  SliderCell.swift
//  Movie-App
//
//  Created by Yaşar Duman on 30.10.2023.
//


import UIKit
import Lottie

final class SliderCell: UICollectionViewCell {
    
    //MARK: - UI Elements
    private lazy var lottieView: LottieAnimationView = {
        let lottieView = LottieAnimationView()
        lottieView.loopMode = .loop
        lottieView.contentMode = .scaleAspectFit
        return lottieView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = MovieColor.playButonBG
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .black)
        return label
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helper Functions
    private func configureUI() {
        contentView.addSubviewsExt(lottieView, titleLabel, textLabel)
        configureLottieView()
        configureTitleLabel()
        configureTextLabel()
    }
    
    private func configureLottieView() { 
        lottieView.anchor(top: contentView.topAnchor,
                          leading: contentView.leadingAnchor,
                          trailing: contentView.trailingAnchor,
                          padding: .init(top: 140),
                          size: .init(heightSize: 300))
    }
    
    private func configureTitleLabel() {
        titleLabel.anchor(top: lottieView.bottomAnchor,
                          leading: contentView.leadingAnchor,
                          trailing: contentView.trailingAnchor,
                          padding: .init(top: 40,
                                         leading: 20,
                                         trailing: 20))
    }
    
    private func configureTextLabel() {
        textLabel.anchor(top: titleLabel.bottomAnchor,
                          leading: contentView.leadingAnchor,
                          trailing: contentView.trailingAnchor,
                          padding: .init(top: 30,
                                         leading: 20,
                                         trailing: 20))
    }
    
    
    // MARK: - Animation Setup
    func animationSetup(animationName: String){
        lottieView.animation = LottieAnimation.named(animationName)
        lottieView.play()
    }
}
