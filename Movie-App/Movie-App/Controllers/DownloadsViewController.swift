//
//  DownloadsViewController.swift
//  Movie-App
//
//  Created by Yaşar Duman on 30.10.2023.
//

import UIKit

class DownloadsViewController: UIViewController {
    //MARK: - Variables
    let vm: DownloadsVM? = DownloadsVM()
    var movies: [Movie] = []
    
    // MARK: - UI Elements
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        return tableView
    }()
 
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = MovieColor.playButonBG
        view.backgroundColor = .secondarySystemBackground
        
        refreshUI()
        configureTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        refreshUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.frame
    }
    // MARK: - Helper Functions
    private func configureTableView(){
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .secondarySystemBackground
    }
    

    private func refreshUI() {
        vm!.fetchFavorites { movies in
            self.movies = movies
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension DownloadsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
    
        let movie = movies[indexPath.row]
        
        if let movieName = movie.original_title ?? movies[indexPath.row].original_name,
           let posterURL = movie.poster_path,
           let imdbScore = movie.vote_average,
           let movieDate = movie.release_date ?? movies[indexPath.row].first_air_date {
            
         cell.configure(with: MovieCellModel(titleName: movieName, posterURL: posterURL, vote_average: imdbScore, release_date: movieDate))
        }
  
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let movie = movies[indexPath.row]
        
        guard let movieName = movie.original_title ?? movie.original_name else {
            return
        }
        
        Task{
            do {
                let moviePreveiwModel  = try await APICaller.shared.getMovie(with: movieName)
          
                let vc = MoviePreviewViewController()
                vc.configure(with: MoviePreviewModel(title: movieName, youtubeView: moviePreveiwModel, movieOverview: movie.overview ?? "", release_date: movie.release_date ?? movie.first_air_date),moviModelIsFavori: movie)
                
                self.navigationController?.pushViewController(vc, animated: true)

            }catch {
                if let movieError = error as? MovieError {
                    print(movieError.rawValue)
                } else {
                    presentAlert(title: "Error!", message: error.localizedDescription, buttonTitle: "OK")
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil") { contextualAction, view, boolValue in
            let movies = self.movies[indexPath.row]
            self.vm!.removeFromFavorites(movies: movies)
            self.refreshUI()
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
