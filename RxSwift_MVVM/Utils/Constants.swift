//
//  Constants.swift
//  RxSwift_MVVM
//
//  Created by Sailor on 11/06/2020.
//  Copyright © 2020 com.sailor. All rights reserved.
//

import Foundation

struct Constants{
    static let apiKey = "?api_key=5bdb3ac95386d3559d610b1e010e676e"
    
    struct URL{
        static let main = "https://api.themoviedb.org/"
        static let urlImages = "https://image.tmdb.org/t/p/w200"
    }
    
    struct EndPoints{
           static let urlListPopularMovies = "3/movie/popular"
           static let urlDetailMovie = "3/movie/"
       }
}
