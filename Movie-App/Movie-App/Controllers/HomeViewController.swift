//
//  HomeViewController.swift
//  Movie-App
//
//  Created by Yaşar Duman on 30.10.2023.
//

import UIKit

// MARK: - HomeViewInterface
protocol HomeViewInterface: AnyObject {
    func configureHeaderView(with moviePath: [Movie])
    func showLoadingIndicator()
    func dismissLoadingIndicator()
    func tableViewReloadData()
    func configureViewDidLoad()
    func pushVC(_ vc: UIViewController)
    func alert(title: String, message: String, buttonTitle: String)
}

final class HomeViewController: UIViewController{
  
    // MARK: - Properties
    private lazy var viewModel = HomeVM(view: self)
    
    // MARK: - Header View
    private var headerView: HeroHeaderUIView?
    
    // MARK: - Section Titles
    private let sectionTitles: [String] = ["Trending Movies", "Trending Tv", "Popular", "Upcoming Movies", "Top rated"]
    
    // MARK: - TableView
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.separatorStyle = .none
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
  
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    // MARK: - LayoutSubviews
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.frame
        // Güvenli alanın altındaki boşluğu hesaplayın
        let safeAreaBottom = view.safeAreaInsets.bottom
        //SafeAreaKadar Boşluk bıraktık
        homeFeedTable.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: safeAreaBottom, right: 0)
  
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        navigationController?.navigationBar.topItem?.backButtonTitle = "Home"
        navigationController?.navigationBar.tintColor = MovieColor.playButonBG
    }
    
    // MARK: - Configure TableView
    private func configureTableView() {
        configureHeaderView()
        view.addSubview(homeFeedTable)
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        homeFeedTable.tableHeaderView = headerView
        homeFeedTable.backgroundColor = .tertiarySystemGroupedBackground
        homeFeedTable.contentInsetAdjustmentBehavior = .never
    }
    
    // MARK: - Configure HeaderView
    private func configureHeaderView() {
        headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
        headerView?.delegate = self
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            cell.configure(with: viewModel.trendingMovies)
            
        case Sections.TrendingTv.rawValue:
            cell.configure(with: viewModel.TrendingTVs)
            
        case Sections.Popular.rawValue:
            cell.configure(with: viewModel.UpcomingMovies)
            
        case Sections.Upcoming.rawValue:
            cell.configure(with: viewModel.Popular)
            
        case Sections.TopRated.rawValue:
            cell.configure(with: viewModel.TopRated)
        default:
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .label
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
}

// MARK: - HomeViewInterface
extension HomeViewController: HomeViewInterface {
    func configureViewDidLoad() {
        configureUI()
        configureTableView()
    }
    
    func tableViewReloadData() {
        DispatchQueue.main.async {
            self.homeFeedTable.reloadData()
        }
    }
    
    //Random Image
    func configureHeaderView(with moviePath: [Movie]) {
        let selectedTitle = moviePath.randomElement()
        headerView?.configure(with: selectedTitle!)
    }
  
    // Displays the loading indicator.
    func showLoadingIndicator() {
        DispatchQueue.main.async {
            self.showLoading()
        }
    }
    // Dismisses the loading indicator.
    func dismissLoadingIndicator() {
    
        DispatchQueue.main.async {
            self.dismissLoading()
        }
    }
    
    func alert(title: String, message: String, buttonTitle: String) {
        presentAlert(title: title, message: message, buttonTitle: buttonTitle)
    }
    
    func pushVC(_ vc: UIViewController) {
        DispatchQueue.main.async{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - CollectionView DidSelect
extension HomeViewController: CollectionViewTableViewCellDelegate {
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: MoviePreviewModel, movieModel: Movie) {
        DispatchQueue.main.async { [weak self] in
            let vc = MoviePreviewViewController()
            vc.configure(with: viewModel,moviModelIsFavori: movieModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
// MARK: - HeroHeaderUIViewProtocol
extension HomeViewController: HeroHeaderUIViewProtocol {
    func showDetail(movie: Movie) {
        viewModel.showDetail(movie: movie)
    }
}
