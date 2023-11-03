//
//  DowloadTableViewCell.swift
//  Movie-App
//
//  Created by Yaşar Duman on 3.11.2023.
//

import UIKit

class DownloadTableViewCell: UITableViewCell {
    //MARK: - Variables
    static let reuseID = "dowloadTableViewCell"
    private var movies: [Movie] = []
   
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
    
    lazy var movieImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "heroImage")
        image.layer.masksToBounds = true
        image.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMinXMaxYCorner
        ]
        image.layer.cornerRadius = 15
        return image
    }()
    
    lazy var movieName: UILabel = {
    let label = UILabel()
    label.text = "A Haunting in Venice"
    label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    label.textColor = .label
    return label
}()
    
    lazy var movieOverview: UILabel = {
       let label = UILabel()
        label.text = "Celebrated sleuth Hercule Poirot, now retired and living in self-imposed exile in Venice, reluctantly attends a Halloween séance at a decaying,"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 2
        label.textColor = .label
        return label
    }()
    
    private lazy var DateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .leading
        return stackView
    }()
    
    lazy var movieReleaseDate: UILabel = {
       let label = UILabel()
        label.text = "2023-09-13"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 2
        label.textColor = .secondaryLabel
        return label
    }()
    
    lazy var ReleaseDateImage: UIImageView = {
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
    
    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .secondarySystemBackground
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    
    // MARK: - UI Configiration
    private func configureUI() {
        contentView.addSubview(containerView)
        containerView.addSubviewsExt(movieName,movieImage,movieOverview,DateStackView,imdbStackView)
        DateStackView.addArrangedSubview(ReleaseDateImage)
        DateStackView.addArrangedSubview(movieReleaseDate)
        imdbStackView.addArrangedSubview(imdbLabel)
        imdbStackView.addArrangedSubview(imdbImageView)
        
        
        configureContainerView()
        configureMovieImage()
        configureMovieName()
        configureMovieOverview()
        configureDateStackView()
        configureImdbStackView()
    }
    
    private func configureContainerView(){
        containerView.anchor(top: contentView.topAnchor,
                             leading: contentView.leadingAnchor,
                             bottom: contentView.bottomAnchor,
                             trailing: contentView.trailingAnchor,
                             padding: .init(top: 10, left: 10, bottom: 10, right: 10)
        )
    }
    
    private func configureMovieImage(){
        movieImage.anchor(top: containerView.topAnchor,
                          leading: containerView.leadingAnchor,
                          bottom: containerView.bottomAnchor,
                          size: .init(width: 100, height: 0)
        )
    }
    private func configureMovieName(){
        movieName.anchor(top: containerView.topAnchor,
                         leading: movieImage.trailingAnchor,
                         trailing: imdbImageView.leadingAnchor,
                         padding: .init(top: 18, left: 10, bottom: 0, right: 5)
        )
    }
    private func configureMovieOverview(){
        movieOverview.anchor(top: movieName.bottomAnchor,
                             leading: movieImage.trailingAnchor,
                             trailing: containerView.trailingAnchor,
                             padding: .init(top: 10, left: 10, bottom: 0, right: 10)
        )
    }
    
    private func configureDateStackView(){
        DateStackView.anchor(top: movieOverview.bottomAnchor,
                             leading: movieImage.trailingAnchor,
                             bottom: containerView.bottomAnchor,
                             padding: .init(top: 10, left: 10, bottom: 10, right: 0)
        )
    }
    
    private func configureImdbStackView(){
        imdbStackView.anchor(top: movieOverview.bottomAnchor,
                             bottom: containerView.bottomAnchor,
                             trailing: containerView.trailingAnchor,
                             padding: .init(top: 10, left: 0, bottom: 10, right: 10)
                             
        )
        // Configure Label
        
    }
    
}

#Preview{
    DownloadTableViewCell()
}
