//
//  HomeViewController.swift
//  Movie-App
//
//  Created by Yaşar Duman on 30.10.2023.
//

import UIKit

// MARK: - HomeViewInterface
protocol HomeViewInterface: AnyObject {
    func SaveDatas(with movie: [Movie], tvs: [Movie], upcoming: [Movie], popular: [Movie], topRated: [Movie])
    func configureHeaderView(with moviePath: [Movie])
    func showLoadingIndicator()
    func dismissLoadingIndicator()
}

class HomeViewController: UIViewController{
    // MARK: - Properties
    private lazy var viewModel = HomeVM()
    
    // MARK: - Data Arrays
    private lazy var trendingMovies: [Movie] = []
    private lazy var TrendingTVs: [Movie] = []
    private lazy var UpcomingMovies: [Movie] = []
    private lazy var Popular: [Movie] = []
    private lazy var TopRated: [Movie] = []
    
    // MARK: - Header View
    private var headerView: HeroHeaderUIView?
    
    // MARK: - Section Titles
    let sectionTitles: [String] = ["Trending Movies", "Trending Tv", "Popular", "Upcoming Movies", "Top rated"]
    
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
        configureUI()
        configureTableView()
     
        viewModel.view = self
        viewModel.getMovies()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Güvenli alanın altındaki boşluğu hesaplayın
        let safeAreaBottom = view.safeAreaInsets.bottom
        //SafeAreaKadar Boşluk bıraktık
        homeFeedTable.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: safeAreaBottom, right: 0)
        homeFeedTable.frame = view.frame
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        view.addSubview(homeFeedTable)
    }
    
    private func configureTableView() {
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        configureHeaderView()
        
        homeFeedTable.tableHeaderView = headerView
        homeFeedTable.backgroundColor = .tertiarySystemGroupedBackground
        homeFeedTable.contentInsetAdjustmentBehavior = .never
    }
    
    // MARK: - Configure HeaderView
    private func configureHeaderView() {
        headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
    }
     
    // MARK: - Data Update
    private func updateTable(with data: [Movie]? = nil, for section: Sections) {
        switch section {
        case .TrendingMovies:
            trendingMovies = data ?? []
        case .TrendingTv:
            TrendingTVs = data ?? []
        case .Popular:
            Popular = data ?? []
        case .Upcoming:
            UpcomingMovies = data ?? []
        case .TopRated:
            TopRated = data ?? []
        }
        
        DispatchQueue.main.async {
            self.homeFeedTable.reloadData()
        }
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
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            cell.configure(with: trendingMovies)
            
        case Sections.TrendingTv.rawValue:
            cell.configure(with: TrendingTVs)
            
        case Sections.Popular.rawValue:
            cell.configure(with: UpcomingMovies)
            
        case Sections.Upcoming.rawValue:
            cell.configure(with: Popular)
            
        case Sections.TopRated.rawValue:
            cell.configure(with: TopRated)
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}

// MARK: - HomeViewInterface
extension HomeViewController: HomeViewInterface {
    //Random Image
    func configureHeaderView(with moviePath: [Movie]) {
        let selectedTitle = moviePath.randomElement()
        headerView?.configure(with: selectedTitle!)
    }
    // Saves data and updates the table.
    func SaveDatas(with movie: [Movie], tvs: [Movie], upcoming: [Movie], popular: [Movie], topRated: [Movie]) {
        self.updateTable(with: movie, for: .TrendingMovies)
        self.updateTable(with: tvs, for: .TrendingTv)
        self.updateTable(with: upcoming, for: .Popular)
        self.updateTable(with: popular, for: .Upcoming)
        self.updateTable(with: topRated, for: .TopRated)
    }
    // Displays the loading indicator.
    func showLoadingIndicator() {
        showLoading()
    }
    // Dismisses the loading indicator.
    func dismissLoadingIndicator() {
        dismissLoading()
    }
}
