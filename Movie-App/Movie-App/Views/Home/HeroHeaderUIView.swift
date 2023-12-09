//
//  HeroHeaderUIView.swift
//  Movie-App
//
//  Created by Yaşar Duman on 30.10.2023.
//

import UIKit

protocol HeroHeaderUIViewProtocol: AnyObject {
    func showDetail(movie: Movie)
}

final class HeroHeaderUIView: UIView {
    // MARK: - Properties
    weak var delegate: HeroHeaderUIViewProtocol?
    var movie: Movie?
    
    //MARK: - UI Elements
    // Movie Name Label
    private lazy var movieName: UILabel = {
        let label = UILabel()
        label.text = "MoviName"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 25,weight: .bold)
        return label
    }()
    
    // Stack View for IMDb Rating
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    // IMDb Rating Label
    lazy var imdbLabel: UILabel = {
        let label = UILabel()
        label.text = "8.7"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 25,weight: .bold)
        return label
    }()
    
    // IMDb Star Icon
    private lazy var imdbImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.tintColor = MovieColor.goldColor
        imageView.image = UIImage(systemName: "star.fill")
        return imageView
    }()
    
    // Play Button
    private lazy var playButton = MovieButton(bgColor: MovieColor.playButonBG,
                                         color:  MovieColor.playButonBG,
                                             title: "Play",
                                             systemImageName: "arrowtriangle.right.fill",
                                             cornerStyle: .small)
    // Download Button
    private lazy var downloadButton = MovieButton(bgColor: .systemRed,
                                             color:  .systemRed,
                                             title: "Download",
                                             systemImageName: "arrow.down.to.line",
                                             cornerStyle: .small)

    // Hero Image View
    private lazy var heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "heroImage")
        return imageView
    }()
    
    // Gradient Layer
    let gradientLayer = CAGradientLayer()
    

    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradient()
        addSubviewsExt(playButton, downloadButton, movieName, stackView)
        stackView.addArrangedSubview(imdbLabel)
        stackView.addArrangedSubview(imdbImageView)

        ConfigureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - LayoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.tertiarySystemGroupedBackground.cgColor
        ]
        downloadButton.layer.borderColor = UIColor.label.cgColor
    }
    
    private func addGradient() {
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.tertiarySystemGroupedBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
 // MARK: - ConfigureUI
    private func ConfigureUI() {
        configurePlayButton()
        configureDownloadButton()
        configuremoviName()
        configureStackView()
    }
    
    private func configurePlayButton() {
        playButton.anchor(leading: leadingAnchor,
                          bottom: bottomAnchor,
                          padding: .init(leading: 20, bottom: 30),
                          size: .init(width: 120, height: 46))
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
    }
    
    private func configureDownloadButton() {
        downloadButton.anchor(leading: playButton.trailingAnchor,
                              bottom: bottomAnchor,
                              padding: .init(leading: 20, bottom: 30),
                              size: .init(width: 140, height: 46))
    }
    
    private func configuremoviName() {
        movieName.anchor(leading:playButton.leadingAnchor,
                        bottom: playButton.topAnchor,
                        padding: .init(bottom: 20))
    }
    
    private func configureStackView() {
        stackView.anchor(leading: movieName.leadingAnchor,
                         bottom: movieName.topAnchor,
                         padding: .init(bottom: 10))
    }
    
    @objc private func playButtonTapped() {
        DispatchQueue.main.async {
            self.delegate?.showDetail(movie: self.movie!)
        }
    }
    
// MARK: - UpdateData
   func configure(with model: Movie) {
        movie = model
    
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(String(describing: model.poster_path!))") else {
            return
        }
        
        heroImageView.sd_setImage(with: url, completed: nil)
        
        if let voteAverage = model.vote_average {
            let formattedValue = String(format: "%.1f", voteAverage)
            DispatchQueue.main.async {
                self.imdbLabel.text = formattedValue
                self.movieName.text = model.original_title ?? model.original_name
            }
        }
    }
}
