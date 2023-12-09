//
//  TitlePreviewViewController.swift
//  Movie-App
//
//  Created by Yaşar Duman on 30.10.2023.
//


import UIKit
import WebKit

final class MoviePreviewViewController: UIViewController {
    
    //MARK: - Variables
    private var movies: Movie? = nil
    private lazy var vm: DetailVM? = DetailVM()
    private lazy var isFavorited = false
    
    // MARK: - UI Elements
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "Harry potter"
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.text = "This is the best movie ever to watch as a kid!"
        return label
    }()
    
    private lazy var downloadButton = MovieButton(bgColor: .red,
                                             color: .red,
                                             title: "Download",
                                             systemImageName: "arrow.down.circle.dotted",
                                             cornerStyle: .small)

    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        return webView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 25
        return stackView
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
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.tintColor = .label
        return image
    }()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviewsExt(webView, scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubviewsExt(titleLabel, DateStackView)
        
        DateStackView.addArrangedSubviewsExt(ReleaseDateImage, movieReleaseDate)
        stackView.addArrangedSubviewsExt(overviewLabel, downloadButton)
        
        configureConstraints()
        configureDownloadButton()
        
    }
    
    // MARK: - Constraints
    private func configureConstraints() {
        webView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                       leading: view.leadingAnchor, 
                       trailing: view.trailingAnchor,
                       size: .init(heightSize: 300))
        
        scrollView.anchor(top: webView.bottomAnchor,
                          leading: view.leadingAnchor,
                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          trailing: view.trailingAnchor,
                          padding: .init(top: 10))
        
        stackView.anchor(top: scrollView.topAnchor,
                         leading: scrollView.leadingAnchor,
                         bottom: scrollView.bottomAnchor,
                         trailing: scrollView.trailingAnchor)
      
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
       titleLabel.anchor(top: stackView.topAnchor,
                             leading: stackView.leadingAnchor,
                            trailing: stackView.trailingAnchor,
                             padding: .init(top: 20, leading: 20))
   
       DateStackView.anchor(top: titleLabel.bottomAnchor,
                            leading: stackView.leadingAnchor,
                            trailing: stackView.trailingAnchor,
                             padding: .init(top: 10, leading: 20))
        
        ReleaseDateImage.anchor(size: .init(width: 20, height: 20))
   
      
        overviewLabel.anchor(top: DateStackView.bottomAnchor,
                             leading: stackView.leadingAnchor,
                             trailing: stackView.trailingAnchor,
                             padding: .init(top: 25, leading: 20, trailing: 20))
        
        downloadButton.anchor(top: overviewLabel.bottomAnchor,
                              leading: stackView.leadingAnchor,
                              bottom: stackView.bottomAnchor,
                              trailing: stackView.trailingAnchor,
                              padding: .init(top: 25, left: 20, bottom: 20, right: 20),
                              size: .init(heightSize: 50))
        downloadButton.addTarget(self, action: #selector(downloadButtonTapped), for: .touchUpInside)
    }
   private func configureDownloadButton() {
        vm!.isFavorited(movies: movies!) { bool in
            self.isFavorited = bool
            self.downloadButton.setImage(UIImage(systemName: bool ? "arrow.down.circle.fill" : "rrow.down.circle.dotted"), for: .normal)
        }
    }
    
    //MARK: - @Actions
    @objc private func downloadButtonTapped() {
        if isFavorited {
            vm!.removeFromFavorites(movies: movies!) { bool in
                self.isFavorited = bool
                self.downloadButton.setImage(UIImage(systemName: "arrow.down.circle.dotted"), for: .normal)
            }
        } else {
            vm!.addToFavorites(movies: movies!) { bool in
                self.isFavorited = bool
                self.downloadButton.setImage(UIImage(systemName: "arrow.down.circle.fill"), for: .normal)
            }
        }
    }
    
    // MARK: - Public Methods
    public func configure(with model: MoviePreviewModel, moviModelIsFavori: Movie) {
        self.movies = moviModelIsFavori
        
        titleLabel.text = model.title
        overviewLabel.text = model.movieOverview
        movieReleaseDate.text = model.release_date
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId)") else {
            return
        }
        
        webView.load(URLRequest(url: url))
    }

}
