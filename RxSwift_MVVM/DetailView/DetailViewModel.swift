//
//  DetailViewModel.swift
//  RxSwift_MVVM
//
//  Created by Sailor on 16/06/2020.
//  Copyright © 2020 com.sailor. All rights reserved.
//

import Foundation
import RxSwift

class DetailViewModel {
    private var managerConnections = ManagerConnections()
    private(set) weak var view: DetailViewController?
    private var router: DetailRouter?
    
    func bind(view: DetailViewController, router: DetailRouter) {
        self.view = view
        self.router = router
        
        self.router?.setSourceView(view)
    }
    
    func getMovieData(movieID: Int) -> Observable<MovieDetail> {
        return managerConnections.getDetailMovies(movieID: movieID)
    }
}
