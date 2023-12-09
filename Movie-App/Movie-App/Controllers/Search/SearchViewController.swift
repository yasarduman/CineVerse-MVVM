//
//  SearchViewController.swift
//  Movie-App
//
//  Created by Yaşar Duman on 3.11.2023.
//


import UIKit

protocol searchVCInterface: AnyObject {
    func configureViewDidLoad()
    func discoverTableReloadData()
    func alert(title: String, message: String, buttonTitle: String)
    func pushVC(vc: UIViewController)
 
}

final class SearchViewController: UIViewController {

    // MARK: - Properties
    private lazy var viewModel = SearchVM(view: self)
    
    // MARK: - UI Elements
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
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTable.frame = view.bounds
    }
}

// MARK: - Table View Data Source and Delegate
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        
        let movie = viewModel.movies[indexPath.row]
        let model = MovieCellModel(titleName: movie.original_name ?? movie.original_title ?? "Unknown name",
                                   posterURL: movie.poster_path ?? "",
                                   vote_average: movie.vote_average ?? 0.0,
                                   release_date: movie.release_date ?? movie.first_air_date)
        
        cell.configure(with: model)
        return cell;
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)
    }
}

// MARK: - UISearchResultsUpdating and SearchResultsViewControllerDelegate
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
    
    
    
// MARK: - DidTapItem SearchResults
    func searchResultsViewControllerDidTapItem(_ viewModel: MoviePreviewModel, movieModel: Movie) {
        
        DispatchQueue.main.async { [weak self] in
            let vc = MoviePreviewViewController()
            vc.configure(with: viewModel,moviModelIsFavori: movieModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension SearchViewController: searchVCInterface {
    
    func pushVC(vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func configureViewDidLoad() {
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(discoverTable)
        discoverTable.delegate = self
        discoverTable.dataSource = self
        navigationItem.searchController = searchController
        
        navigationController?.navigationBar.tintColor = MovieColor.playButonBG
        
        searchController.searchResultsUpdater = self
    }
    
    func discoverTableReloadData() {
        DispatchQueue.main.async {
            self.discoverTable.reloadData()
        }
    }
    
    func alert(title: String, message: String, buttonTitle: String) {
        presentAlert(title: title, message: message, buttonTitle: buttonTitle)
    }
}
