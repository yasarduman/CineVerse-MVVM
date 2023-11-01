//
//  HomeVM.swift
//  Movie-App
//
//  Created by Yaşar Duman on 31.10.2023.
//

import Foundation
// MARK: - Sections Enum
enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

protocol HomeVMInterface {
    var view: HomeViewInterface? { get set }
    func getMovies()
}

final class HomeVM {
    var view: HomeViewInterface?
}

extension HomeVM: HomeVMInterface {
    func getMovies(){
        //view?.loadingVC?.showLoadingView()

        Task{
            do {
                let getTrendingMovies  = try await APICaller.shared.getTrendingMovies().results
                let getTrendingTVs     = try await APICaller.shared.getTrendingTVs().results
                let getUpcomingMovies  = try await APICaller.shared.getUpcomingMovies().results
                let getPopularMovies   = try await APICaller.shared.getPopular().results
                let getTopRated        = try await APICaller.shared.getTopRated().results
                
                view?.SaveDatas(with: getTrendingMovies, tvs: getTrendingTVs, upcoming: getUpcomingMovies, popular: getPopularMovies, topRated: getTopRated)
                view?.configureHeaderView(with: getTrendingMovies)
             
               //view?.loadingVC?.dismissLoadingView()
            }catch {
                if let movieError = error as? MovieError {
                    print(movieError.rawValue)
                    //view?.loadingVC?.presentAlert(title: "Something went wrong‼️", message: movieError.rawValue, buttonTitle: "Ok")
                } else {
                    // view?.loadingVC?.presentDefualtError()
                }
             
                //view?.loadingVC?.dismissLoadingView()
            }
        }
    }
    
}
