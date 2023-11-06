//
//  TitlePreviewViewController.swift
//  Netflix Clone
//
//  Created by Amr Hossam on 07/01/2022.
//

import UIKit
import WebKit

class MoviePreviewViewController: UIViewController {
    
    //MARK: - Variables
    var movies: Movie? = nil
    var vm: DetailVM? = DetailVM()
    lazy var isFavorited = false
    
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
        view.addSubview(webView)
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(DateStackView)
        
        DateStackView.addArrangedSubview(ReleaseDateImage)
        DateStackView.addArrangedSubview(movieReleaseDate)
        stackView.addArrangedSubview(overviewLabel)
        stackView.addArrangedSubview(downloadButton)
  
        
        configureConstraints()
        configureDownloadButton()
        
    }
    // MARK: - Constraints
    private func configureConstraints() {
        
        webView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                       leading: view.leadingAnchor, 
                       trailing: view.trailingAnchor,
                       padding: .init(top: 0, left: 0, bottom: 0, right: 0),
                       size: .init(width: 0, height: 300))
        
        scrollView.anchor(top: webView.bottomAnchor,
                          leading: view.leadingAnchor,
                          bottom: view.safeAreaLayoutGuide.bottomAnchor,
                          trailing: view.trailingAnchor,
                          padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        
        stackView.anchor(top: scrollView.topAnchor,
                         leading: scrollView.leadingAnchor,
                         bottom: scrollView.bottomAnchor,
                         trailing: scrollView.trailingAnchor)
      
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
       titleLabel.anchor(top: stackView.topAnchor,
                             leading: stackView.leadingAnchor,
     
                             padding: .init(top: 20, left: 20, bottom: 0, right: 0))
   
       DateStackView.anchor(top: titleLabel.bottomAnchor,

                            leading: stackView.leadingAnchor,
                             padding: .init(top: 10, left: 20, bottom: 0, right: 0))
        
        ReleaseDateImage.anchor(size: .init(width: 20, height: 20))
   
      
        
        overviewLabel.anchor(top: DateStackView.bottomAnchor,
                             leading: stackView.leadingAnchor,
                             trailing: stackView.trailingAnchor,
                             padding: .init(top: 25, left: 20, bottom: 0, right: 20))
        
        downloadButton.anchor(top: overviewLabel.bottomAnchor,
                              leading: stackView.leadingAnchor,
                              bottom: stackView.bottomAnchor,
                              trailing: stackView.trailingAnchor,
                              padding: .init(top: 25, left: 20, bottom: 20, right: 20),
                              size: .init(width: 0, height: 50))
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
    public func configure(with model: MoviePreviewViewModel, moviModelIsFavori: Movie) {
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
