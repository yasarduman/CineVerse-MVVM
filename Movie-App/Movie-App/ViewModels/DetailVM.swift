//
//  DetailVM.swift
//  Movie-App
//
//  Created by Yaşar Duman on 30.10.2023.
//

import FirebaseFirestore
import FirebaseAuth

class DetailVM {
    let currentUserID = Auth.auth().currentUser!.uid
    
    func addToFavorites(movies: Movie, completion: @escaping (Bool) -> Void) {
        
        let data: [String: Any] = [
               "id": movies.id,
               "original_title": movies.original_title ?? "",
               "original_name": movies.original_name ?? "",
               "overview": movies.overview ?? "",
               "poster_path": movies.poster_path ?? "",
               "media_type": movies.media_type ?? "",
               "release_date": movies.release_date ?? "",
               "first_air_date": movies.first_air_date ?? "",
               "vote_average": movies.vote_average ?? 0.0,
               "vote_count": movies.vote_count ?? 0
           ]as [String : Any]
        
        Firestore.firestore()
            .collection("UsersInfo")
            .document(currentUserID)
            .collection("favorites")
            .document(String(movies.id))
            .setData(data) { error in
                if let error = error {
                    print(error.localizedDescription)
                }
                self.isFavorited(movies: movies) { bool in
                    completion(bool)
                }
            }
    }
    
    func removeFromFavorites(movies: Movie, completion: @escaping (Bool) -> Void) {
        Firestore.firestore()
            .collection("UsersInfo")
            .document(currentUserID)
            .collection("favorites")
            .document(String(movies.id))
            .delete { error in
                if let error = error {
                    print(error.localizedDescription)
                }
                self.isFavorited(movies: movies) { bool in
                    completion(bool)
                }
            }
    }
    
    func isFavorited(movies: Movie, completion: @escaping (Bool) -> Void) {
        Firestore.firestore()
            .collection("UsersInfo")
            .document(currentUserID)
            .collection("favorites")
            .document(String(movies.id))
            .getDocument { snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                if let snapshot = snapshot {
                    completion(snapshot.exists)
                }
            }
    }
    
}
