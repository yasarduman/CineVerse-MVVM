//
//  SearchViewController.swift
//  Netflix Clone
//
//  Created by Amr Hossam on 04/11/2021.
//

import UIKit

class SearchViewController: UIViewController {

    
    private var movies: [Movie] = [Movie]()

    private let discoverTable: UITableView = {
        let table = UITableView()
        table.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        return table
    }()
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Search for a Movie or a Tv show"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(discoverTable)
        discoverTable.delegate = self
        discoverTable.dataSource = self
        navigationItem.searchController = searchController
        
        navigationController?.navigationBar.tintColor = MovieColor.playButonBG
        fetchDiscoverMovies()
        
        searchController.searchResultsUpdater = self
    }
    
    
    private func fetchDiscoverMovies() {
        
        Task{
            do {
                let getUpcomingMovies  = try await APICaller.shared.getDiscoverMovies().results
                self.movies = getUpcomingMovies
                DispatchQueue.main.async {
                    self.discoverTable.reloadData()
                }
            }catch {
                if let movieError = error as? MovieError {
                    print(movieError.rawValue)
                } else {
                   
                }
                
            }
        }
        
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTable.frame = view.bounds
    }
 
    

}


extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        
        let movie = movies[indexPath.row]
        let model = MovieViewModel(titleName: movie.original_name ?? movie.original_title ?? "Unknown name", posterURL: movie.poster_path ?? "", vote_average: movie.vote_average ?? 0.0, release_date: movie.release_date ?? movie.first_air_date)
        cell.configure(with: model)
        
        return cell;
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let movie = movies[indexPath.row]
        
        guard let movieName = movie.original_title ?? movie.original_name else {
            return
        }
        
        
        Task{
            do {
                let moviePreviewModel  = try await APICaller.shared.getMovie(with: movieName)
                DispatchQueue.main.async {
                    let vc = MoviePreviewViewController()
                    vc.configure(with: MoviePreviewViewModel(title: movieName, youtubeView: moviePreviewModel, movieOverview: movie.overview ?? "",  release_date: movie.release_date ?? movie.first_air_date),moviModelIsFavori: movie )
                    self.navigationController?.pushViewController(vc, animated: true)
                }
               
            }catch {
                if let movieError = error as? MovieError {
                    print(movieError.rawValue)
                } else {
                   
                }
                
            }
        }
        
        
        
      
    }
}

extension SearchViewController: UISearchResultsUpdating, SearchResultsViewControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultsController = searchController.searchResultsController as? SearchResultsViewController else {
                  return
              }
        resultsController.delegate = self
      
        Task{
            do {
                let getUpcomingMovies  = try await APICaller.shared.search(with: query).results.filter({$0.poster_path != nil})
                resultsController.movies = getUpcomingMovies
                resultsController.searchResultsCollectionView.reloadData()
               
            }catch {
                if let movieError = error as? MovieError {
                    print(movieError.rawValue)
                } else {
                   
                }
                
            }
        }
    }
    
    
    
    func searchResultsViewControllerDidTapItem(_ viewModel: MoviePreviewViewModel, movieModel: Movie) {
        
        DispatchQueue.main.async { [weak self] in
            let vc = MoviePreviewViewController()
            vc.configure(with: viewModel,moviModelIsFavori: movieModel )
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
