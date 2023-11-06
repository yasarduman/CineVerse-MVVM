//
//  TitleCollectionViewCell.swift
//  Movie-App
//
//  Created by Yaşar Duman on 30.10.2023.
//


import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "MovieCollectionViewCell"
    
    // MARK: - UI Elements
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var imdbButton = MovieButton(bgColor: .red,
                                              color:   MovieColor.playButonBG,
                                              title: "",
                                              cornerStyle: .capsule)
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
        posterImageView.addSubview(imdbButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Layout Subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
        imdbButton.anchor(top: posterImageView.topAnchor,
                          trailing: posterImageView.trailingAnchor,
                          padding: .init(top: 6, left: 0, bottom: 0, right: 6),
                          size: .init(width: 50, height: 25))
    }
    
    // MARK: - Public Methods
    public func configure(with model: Movie) {
        let posterPath = model.poster_path
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath!)") else {
            return
        }
        
        posterImageView.sd_setImage(with: url, completed: nil)
        if let voteAverage = model.vote_average {
            let formattedValue = String(format: "%.1f", voteAverage)
            self.imdbButton.setTitle(formattedValue, for: UIControl.State.normal)
        }
    }
    
}
