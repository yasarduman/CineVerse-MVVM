//
//  TitleCollectionViewCell.swift
//  Movie-App
//
//  Created by Yaşar Duman on 30.10.2023.
//


import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {
    
    
    static let identifier = "TitleCollectionViewCell"
    
     private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    lazy var containerImdb: UIView = {
        let container = UIView()
        container.backgroundColor = MovieColor.playButonBG
   
        return container
    }()
    
    private lazy var imdbLabel: UILabel = {
        let label = UILabel()
        label.text = "8.7"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18,weight: .bold)
        return label
    }()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
        posterImageView.addSubview(containerImdb)
        containerImdb.addSubview(imdbLabel)
       
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
        containerImdb.anchor(top: posterImageView.topAnchor,
                             trailing: posterImageView.trailingAnchor,
                             padding: .init(top: 10, left: 0, bottom: 0, right: 10),
                             size: .init(width: 60, height: 25))
        containerImdb.layer.cornerRadius = containerImdb.frame.height / 2
        imdbLabel.centerInSuperview()
    }
    
    
    public func configure(with model: Movie) {
        let posterPath = model.poster_path
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath!)") else {
            return
        }
        
        posterImageView.sd_setImage(with: url, completed: nil)
        //Number Formatter %.1f
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 1
        
        let doubleValue: Double = model.vote_average!
        if numberFormatter.string(from: NSNumber(value: doubleValue)) != nil {
            DispatchQueue.main.async {
                let formattedValue = String(format: "%.1f", doubleValue)
                self.imdbLabel.text = formattedValue
            }
            
        }
    }
    
}
