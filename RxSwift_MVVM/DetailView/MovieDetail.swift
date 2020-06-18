//
//  MovieDetail.swift
//  RxSwift_MVVM
//
//  Created by Sailor on 16/06/2020.
//  Copyright © 2020 com.sailor. All rights reserved.
//

import Foundation

struct MovieDetail: JsonDecodable {
    //let adult: Bool
    //let backdropPath: String
    let budget: Int?
    let title: String?
    let poster_path: String?
    let overview: String?
    let release_date: String?
    let vote_average: Double?
   // let homepage: String
    let id: Int?
    let popularity: Double?
   
    
    enum CodinKeys: String, CodingKey {
        //case adult
       // case backdropPath = "backdrop_path"
        case budget
        case title
        case poster_path
        case overview
        case release_date
        case vote_average
       // case homepage
        case id
        case popularity
    }
    
    
}
