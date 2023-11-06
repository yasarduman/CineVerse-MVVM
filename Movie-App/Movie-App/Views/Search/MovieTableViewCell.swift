//
//  TitleTableViewCell.swift
//  Netflix Clone
//
//  Created by Amr Hossam on 24/12/2021.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    static let identifier = "TitleTableViewCell"

     //MARK: - UI Elements
     private lazy var containerView: UIView = {
         let container = UIView()
         container.backgroundColor = .secondarySystemBackground
         container.layer.cornerRadius = 15
         container.layer.shadowColor = UIColor.label.cgColor
         container.layer.shadowOffset = CGSize(width: 0, height: 0)
         container.layer.shadowOpacity = 0.6
         container.layer.shadowRadius = 4
         container.layer.masksToBounds = false
         return container
     }()
     
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Başlık glecek Inanıyorumdsadsdasda"
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        return label
    }()
    private let playTitleButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 35))
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
  
    
    lazy var titlesPosterUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "heroImage")
        imageView.layer.masksToBounds = true
        imageView.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMinXMaxYCorner
        ]
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    private lazy var DateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var movieReleaseDate: UILabel = {
       let label = UILabel()
        label.text = "2023-09-13"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var ReleaseDateImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "calendar.badge.clock")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.tintColor = .label
        return image
    }()
    
    private lazy var imdbStackView: UIStackView = {
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
        label.font = UIFont.systemFont(ofSize: 15,weight: .bold)
        return label
    }()
    
    private lazy var imdbImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = MovieColor.goldColor
        imageView.image = UIImage(systemName: "star.fill")
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .secondarySystemBackground
        selectionStyle = .none
        contentView.addSubview(containerView)
        containerView.addSubviewsExt(titlesPosterUIImageView,titleStackView,DateStackView,imdbStackView)
        
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(playTitleButton)
        DateStackView.addArrangedSubview(ReleaseDateImage)
        DateStackView.addArrangedSubview(movieReleaseDate)
        imdbStackView.addArrangedSubview(imdbLabel)
        imdbStackView.addArrangedSubview(imdbImageView)
    
        
        applyConstraints()
    }
    
    
    private func applyConstraints() {
        
        containerView.anchor(top: contentView.topAnchor,
                             leading: contentView.leadingAnchor,
                             bottom: contentView.bottomAnchor,
                             trailing: contentView.trailingAnchor,
                             padding: .init(top: 10, left: 10, bottom: 10, right: 10))
    
        titlesPosterUIImageView.anchor(top: containerView.topAnchor,
                          leading: containerView.leadingAnchor,
                          bottom: containerView.bottomAnchor,
                          size: .init(width: 100, height: 0))
     
        titleStackView.anchor(top: containerView.topAnchor,
                          leading: titlesPosterUIImageView.trailingAnchor,
                          trailing: containerView.trailingAnchor,
                          padding: .init(top: 25, left: 10, bottom: 0, right: 10))
        
        playTitleButton.anchor(size: .init(width: 35, height: 35))

        DateStackView.anchor(leading: titleLabel.leadingAnchor,
                             bottom: containerView.bottomAnchor,
                             padding: .init(top: 15, left: 0, bottom: 10, right: 0))
         
        imdbStackView.anchor(bottom: containerView.bottomAnchor,
                             trailing: containerView.trailingAnchor,
                             padding: .init(top: 15, left: 0, bottom: 10, right: 10))
    }
    
    public func configure(with model: MovieViewModel) {

        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {
            return
        }
        titlesPosterUIImageView.sd_setImage(with: url, completed: nil)
        titleLabel.text = model.titleName
        movieReleaseDate.text = model.release_date
        
        if let voteAverage = model.vote_average {
            let formattedValue = String(format: "%.1f", voteAverage)
            self.imdbLabel.text = formattedValue
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

