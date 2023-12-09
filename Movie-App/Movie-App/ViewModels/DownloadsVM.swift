//
//  DownloadsVM.swift
//  Movie-App
//
//  Created by Yaşar Duman on 30.10.2023.
//

import FirebaseFirestore
import FirebaseAuth


protocol DownloadVMInterface {
    func viewDidLoad()
    func refreshUI()
    func didSelectRowAt(at indexPath: IndexPath)
}

final class DownloadsVM {
    var view: DownloadVCInterface?
    let currentUserID = Auth.auth().currentUser!.uid
    var movies: [Movie] = []
    
    
    init(view: DownloadVCInterface? = nil) {
        self.view = view
    }
    
    func fetchFavorites(completion: @escaping([Movie]) -> Void) {
        Firestore.firestore()
            .collection("UsersInfo")
            .document(currentUserID)
            .collection("favorites")
            .getDocuments { snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let documents = snapshot?.documents else { return }
                let movies = documents.compactMap({try? $0.data(as: Movie.self)})
                completion(movies)
            }
    }
    
    
    
    func removeFromFavorites(movies: Movie) {
        Firestore.firestore()
            .collection("UsersInfo")
            .document(currentUserID)
            .collection("favorites")
            .document(String(movies.id))
            .delete { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
    }
    
   
}

extension DownloadsVM: DownloadVMInterface{
    func didSelectRowAt(at indexPath: IndexPath) {
        
        let movie = movies[indexPath.row]
        
        guard let movieName = movie.original_title ?? movie.original_name else {
            return
        }
        
        Task{
            do {
                let moviePreveiwModel  = try await APICaller.shared.getMovie(with: movieName)
          
                let vc = await MoviePreviewViewController()
                await vc.configure(with: MoviePreviewModel(title: movieName, youtubeView: moviePreveiwModel, movieOverview: movie.overview ?? "", release_date: movie.release_date ?? movie.first_air_date),moviModelIsFavori: movie)
                
                view?.pushVC(vc: vc)

            }catch {
                if let movieError = error as? MovieError {
                    print(movieError.rawValue)
                } else {
                    view?.alert(title: "Error!", message: error.localizedDescription, buttonTitle: "OK")
                }
            }
        }
    }
    
    func viewDidLoad() {
        view?.configureViewDidLoad()
        refreshUI()
    }
    
    func refreshUI() {
       fetchFavorites { movies in
           self.movies = movies
           self.view?.tableViewReloadData()
       }
   }
}
