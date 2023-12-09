//
//  SearchVM.swift
//  Movie-App
//
//  Created by Yaşar Duman on 9.12.2023.
//

import Foundation


protocol searchVMInterface {
    func viewDidLoad()
    func didSelectRow(at indexPath: IndexPath)
    func fetchDiscoverMovies()
    func showDetail(movie: Movie , movieName: String)

}

final class SearchVM {
    private weak var view: searchVCInterface?
    var movies: [Movie] = []
    
    init(view: searchVCInterface? = nil) {
        self.view = view
    }
}

extension SearchVM: searchVMInterface {
 
    func didSelectRow(at indexPath: IndexPath) {
        
        let movie = movies[indexPath.row]
        
        guard let movieName = movie.original_title ?? movie.original_name else {
            return
        }
        
        showDetail(movie: movie, movieName: movieName)
    }
    
    func viewDidLoad() {
        view?.configureViewDidLoad()
        fetchDiscoverMovies()
    }
    
    // MARK: - Data Fetching
    func fetchDiscoverMovies() {
        Task{
            do {
                let getUpcomingMovies  = try await APICaller.shared.getDiscoverMovies().results
                self.movies = getUpcomingMovies
                view?.discoverTableReloadData()
            }catch {
                if let movieError = error as? MovieError {
                    print(movieError.rawValue)
                } else {
                    view?.alert(title: "Error!", message: error.localizedDescription, buttonTitle: "OK")
                }
            }
        }
    }
    
    func showDetail(movie: Movie , movieName: String) {
        Task{
            do {
                let moviePreviewModel  = try await APICaller.shared.getMovie(with: movieName)
                DispatchQueue.main.async {
                    let vc = MoviePreviewViewController()
                    vc.configure(with: MoviePreviewModel(title: movieName, youtubeView: moviePreviewModel, movieOverview: movie.overview ?? "",  release_date: movie.release_date ?? movie.first_air_date),moviModelIsFavori: movie )
                    self.view?.pushVC(vc: vc)
                }
            }catch {
                if let movieError = error as? MovieError {
                    print(movieError.rawValue)
                } else {
                    view?.alert(title: "Error", message: error.localizedDescription, buttonTitle: "OK")
                }
            }
        }
    }
}
