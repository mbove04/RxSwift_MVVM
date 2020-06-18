//
//  Movies.swift
//  RxSwift_MVVM
//
//  Created by Sailor on 11/06/2020.
//  Copyright © 2020 com.sailor. All rights reserved.
//

import Foundation

struct Movies: Codable {
    let listOfMovies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case listOfMovies = "results"
    }
}

struct Movie: Codable {
    let title: String
    let popularity: Double
    let MovieID: Int
    let voteAverage: Double
    let overView: String
    //let releaseDate: String
    let image: String
    
    
    enum CodingKeys: String, CodingKey{
        case title
        case popularity
        case MovieID = "id"
        case voteAverage = "vote_average"
        case overView = "overview"
        //case releaseDate = "release_date"
        case image = "poster_path"
    }
}
