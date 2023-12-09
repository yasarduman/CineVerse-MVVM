//
//  HomeVM.swift
//  Movie-App
//
//  Created by Yaşar Duman on 31.10.2023.
//


// MARK: - Sections Enum
enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

protocol HomeVMInterface {

    func viewDidLoad()
    func showDetail(movie: Movie)
    func getMovies()
}

final class HomeVM {
    private weak var view: HomeViewInterface?
    
    // MARK: - Data Arrays
    lazy var trendingMovies: [Movie] = []
    lazy var TrendingTVs: [Movie] = []
    lazy var UpcomingMovies: [Movie] = []
    lazy var Popular: [Movie] = []
    lazy var TopRated: [Movie] = []
    
    
    init(view: HomeViewInterface? = nil) {
        self.view = view
    }
    
    
  
    func showLoadingView() {
        view?.showLoadingIndicator()
       }
    
    func hideLoadingView() {
           view?.dismissLoadingIndicator()
       }
}


extension HomeVM: HomeVMInterface {
    func showDetail(movie: Movie) {
        let vc = MoviePreviewViewController()
        Task{
            do {
                let moviePreviewModel  = try await APICaller.shared.getMovie(with: movie.original_title! + " trailer")
                guard let movieOverview = movie.overview else {
                    return
                }
             
                let viewModel = MoviePreviewModel(title: movie.original_title!,
                                                      youtubeView: moviePreviewModel,
                                                      movieOverview: movieOverview,
                                                      release_date: movie.release_date ?? movie.first_air_date)
                await vc.configure(with: viewModel, moviModelIsFavori: movie)
                view?.pushVC(vc)
               
            }catch {
                if let movieError = error as? MovieError {
                    print(movieError.rawValue)
                } else {
                    view?.alert(title: "Error!", message: error.localizedDescription, buttonTitle: "Ok")
                }
            }
        }
    }
    
    func viewDidLoad() {
        view?.configureViewDidLoad()
        getMovies()
    }
    
    func getMovies(){
        showLoadingView()
        Task{
            do {
                let getTrendingMovies  = try await APICaller.shared.getTrendingMovies().results
                let getTrendingTVs     = try await APICaller.shared.getTrendingTVs().results
                let getUpcomingMovies  = try await APICaller.shared.getUpcomingMovies().results
                let getPopularMovies   = try await APICaller.shared.getPopular().results
                let getTopRated        = try await APICaller.shared.getTopRated().results
                
          
                updateTable(with: getTrendingMovies, for: .TrendingMovies)
                updateTable(with: getTrendingTVs, for: .TrendingTv)
                updateTable(with: getUpcomingMovies, for: .Popular)
                updateTable(with: getPopularMovies, for: .Upcoming)
                updateTable(with: getTopRated, for: .TopRated)
                
                view?.configureHeaderView(with: getTrendingMovies)
                hideLoadingView()
            }catch {
                if let movieError = error as? MovieError {
                    print(movieError.rawValue)
                } else {
                   
                }
                hideLoadingView()
            }
        }
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
        
         view?.tableViewReloadData()
    }
}
