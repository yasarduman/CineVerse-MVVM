//
//  HeroHeaderUIView.swift
//  Movie-App
//
//  Created by Yaşar Duman on 30.10.2023.
//


import UIKit

class HeroHeaderUIView: UIView {
    
    //MARK: - UI Elements
    
    private lazy var moviName: UILabel = {
        let label = UILabel()
        label.text = "MoviName"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 25,weight: .bold)
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    lazy var imdbLabel: UILabel = {
        let label = UILabel()
        label.text = "8.7"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 25,weight: .bold)
        return label
    }()
    private lazy var imdbImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.tintColor = MovieColor.goldColor
        imageView.image = UIImage(systemName: "star.fill")
        return imageView
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20,weight: .bold)
        button.setTitleColor(.label, for: .normal)
        button.setImage(UIImage(systemName: "arrowtriangle.right.fill"), for: UIControl.State.normal)
        button.semanticContentAttribute = .forceLeftToRight
        button.sizeToFit()
        button.tintColor = .label
        button.backgroundColor    = MovieColor.playButonBG
        button.layer.cornerRadius = 5
        return button
    }()
    
    private lazy var downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20,weight: .bold)
        button.setTitleColor(.label, for: .normal)

        button.setImage(UIImage(systemName: "plus"), for: UIControl.State.normal)
        button.semanticContentAttribute = .forceLeftToRight
        button.sizeToFit()
        button.tintColor = .label
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        return button
    }()
    
    private lazy var heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "heroImage")
        return imageView
    }()
    let gradientLayer = CAGradientLayer()
   
    
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradient()
        addSubview(playButton)
        addSubview(downloadButton)
        addSubview(moviName)
        addSubview(stackView)
        stackView.addArrangedSubview(imdbLabel)
        stackView.addArrangedSubview(imdbImageView)
        
        
        ConfigureUI()
    }
    private func addGradient() {
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.tertiarySystemGroupedBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    private func ConfigureUI() {
        configurePlayButton()
        configureDownloadButton()
        configuremoviName()
        configureStackView()
    }
    
    private func configurePlayButton() {
        playButton.anchor(leading: leadingAnchor,
                          bottom: bottomAnchor,
                          padding: .init(top: 0, left: 20, bottom: 30, right: 0),
                          size: .init(width: 120, height: 46))
    }
   
    
    private func configureDownloadButton() {
        downloadButton.anchor(leading: playButton.trailingAnchor,
                              bottom: bottomAnchor,
                              padding: .init(top: 0, left: 20, bottom: 30, right: 0),
                              size: .init(width: 140, height: 46))
    }
    
    private func configuremoviName() {
        moviName.anchor(leading:playButton.leadingAnchor,
                        bottom: playButton.topAnchor,
                        padding: .init(top: 0, left: 0, bottom: 20, right: 0))
    }
    
    private func configureStackView() {
        stackView.anchor(leading: moviName.leadingAnchor,
                         bottom: moviName.topAnchor,
                         padding: .init(top: 0, left: 0, bottom: 10, right: 0))
    }
    

    public func configure(with model: Movie) {
    
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(String(describing: model.poster_path!))") else {
            return
        }
        
        heroImageView.sd_setImage(with: url, completed: nil)
        
        //Number Formatter %.1f
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 1
        
        let doubleValue: Double = model.vote_average!
        if numberFormatter.string(from: NSNumber(value: doubleValue)) != nil {
            DispatchQueue.main.async {
                let formattedValue = String(format: "%.1f", doubleValue)
                self.imdbLabel.text = formattedValue
                self.moviName.text = model.original_name ?? model.original_title
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.tertiarySystemGroupedBackground.cgColor
        ]
        downloadButton.layer.borderColor = UIColor.label.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
