//
//  SearchResultsViewController.swift
//  Movie-App
//
//  Created by Yaşar Duman on 3.11.2023.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func searchResultsViewControllerDidTapItem(_ viewModel: MoviePreviewModel, movieModel: Movie)

}

final class SearchResultsViewController: UIViewController {
    // MARK: - Properties
    public var movies: [Movie] = [Movie]()
    
    public weak var delegate: SearchResultsViewControllerDelegate?
    
    // MARK: - UI Elements
    public let searchResultsCollectionView: UICollectionView = {
       
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        return collectionView
    }()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(searchResultsCollectionView)
        
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultsCollectionView.frame = view.bounds
    }
}

// MARK: - UICollectionView Data Source and Delegate
extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        
        let movie = movies[indexPath.row]
        cell.configure(with: movie /*?? ""*/)
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let movie = movies[indexPath.row]
        let movieName = movie.original_title ?? ""
        
        Task{
            do {
                let getUpcomingMovies  = try await APICaller.shared.getMovie(with: movieName)
                self.delegate?.searchResultsViewControllerDidTapItem(MoviePreviewModel(title: movie.original_title ?? "", 
                                                                                       youtubeView: getUpcomingMovies,
                                                                                       movieOverview: movie.overview ?? "",
                                                                                       release_date: movie.release_date ?? movie.first_air_date),
                                                                     movieModel: movie)
            }catch {
                if let movieError = error as? MovieError {
                    print(movieError.rawValue)
                } else {
                    presentAlert(title: "Error", message: error.localizedDescription, buttonTitle: "OK")
                }
            }
        }
    }
}
