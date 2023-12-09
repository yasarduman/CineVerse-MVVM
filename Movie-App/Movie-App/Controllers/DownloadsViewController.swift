//
//  DownloadsViewController.swift
//  Movie-App
//
//  Created by Yaşar Duman on 30.10.2023.
//

import UIKit

protocol DownloadVCInterface{
    func configureViewDidLoad()
    func tableViewReloadData()
    func pushVC(vc: UIViewController) 
    func alert(title: String, message: String, buttonTitle: String)
}

final class DownloadsViewController: UIViewController {
    //MARK: - Variables
    private lazy var viewModel: DownloadsVM? = DownloadsVM(view: self)
  
    
    // MARK: - UI Elements
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        return tableView
    }()
 
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.viewDidLoad()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.refreshUI()
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
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension DownloadsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.movies.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
    
        let movie = viewModel?.movies[indexPath.row]
        
        if let movieName = movie?.original_title ?? viewModel?.movies[indexPath.row].original_name,
           let posterURL = movie?.poster_path,
           let imdbScore = movie?.vote_average,
           let movieDate = movie?.release_date ?? viewModel?.movies[indexPath.row].first_air_date {
            
         cell.configure(with: MovieCellModel(titleName: movieName, posterURL: posterURL, vote_average: imdbScore, release_date: movieDate))
        }
  
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel?.didSelectRowAt(at: indexPath)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil") { contextualAction, view, boolValue in
            let movies = self.viewModel?.movies[indexPath.row]
            self.viewModel?.removeFromFavorites(movies: movies!)
            self.viewModel?.refreshUI()
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension DownloadsViewController: DownloadVCInterface{
    func alert(title: String, message: String, buttonTitle: String) {
        presentAlert(title: title, message:message, buttonTitle: buttonTitle)
    }
    
    func pushVC(vc: UIViewController) {
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableViewReloadData() {
        self.tableView.reloadData()
    }
    
    func configureViewDidLoad() {
        navigationController?.navigationBar.tintColor = MovieColor.playButonBG
        view.backgroundColor = .secondarySystemBackground
        configureTableView()
    }
}
