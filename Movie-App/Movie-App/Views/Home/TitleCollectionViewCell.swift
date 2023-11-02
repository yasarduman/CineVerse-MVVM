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
    
    private lazy var imdbLabel: UILabel = {
        let label = UILabel()
        label.text = "8.7"
        label.textColor = .white
        label.backgroundColor = MovieColor.goldColor
        label.font = UIFont.systemFont(ofSize: 20,weight: .bold)
        return label
    }()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
        posterImageView.addSubview(imdbLabel)
       
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
        imdbLabel.anchor(top: posterImageView.topAnchor,
                         trailing: posterImageView.trailingAnchor,
                         padding: .init(top: 5, left: 0, bottom: 0, right: 5))
    }
    
    
    public func configure(with model: String) {
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else {
            return
        }
        
        posterImageView.sd_setImage(with: url, completed: nil)
    }
    
}
