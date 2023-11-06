//
//  TitleViewModel.swift
//  Netflix Clone
//
//  Created by Amr Hossam on 24/12/2021.
//

import Foundation


struct MovieViewModel : Codable{
    let titleName: String
    let posterURL: String
    let vote_average: Double?
    let release_date: String?
}
