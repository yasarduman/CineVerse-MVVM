//
//  SearchViewController.swift
//  Movie-App
//
//  Created by Yaşar Duman on 30.10.2023.
//


import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - UI Elements
    private let searchController      = UISearchController(searchResultsController: nil)
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .secondarySystemBackground
        tableView.register(DownloadTableViewCell.self, forCellReuseIdentifier: DownloadTableViewCell.reuseID)
        return tableView
    }()

    // MARK: - Properties
    lazy var workItem = WorkItem()
  
    override func viewDidLoad() {
        super.viewDidLoad()
     
        configureUI()
    }

    // MARK: - Helper Functions
    private func configureUI() {
        view.backgroundColor = .secondarySystemBackground
        
        createSearchBar()
        configureTableView()
        
    }
    
    private func configureTableView(){
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         leading: view.safeAreaLayoutGuide.leadingAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         trailing: view.safeAreaLayoutGuide.trailingAnchor)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DownloadTableViewCell.reuseID, for: indexPath) as? DownloadTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

//MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {

    private func createSearchBar() {
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        workItem.perform(after: 0.5) {
            if !searchText.isEmpty {
                print(searchText)
            } else {
             
            }
        }
    }
}
