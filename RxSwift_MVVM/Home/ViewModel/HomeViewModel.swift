//
//  HomeViewModel.swift
//  RxSwift_MVVM
//
//  Created by Sailor on 11/06/2020.
//  Copyright © 2020 com.sailor. All rights reserved.
//

import Foundation
import RxSwift

class HomeViewModel{
    private weak var view: HomeViewController?
    private var router: HomeRouter?
    private var managerConnections = ManagerConnections()
    
    //conexiones
    func bind(view: HomeViewController, router: HomeRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func getListMoviesData() -> Observable<[Movie]>{
        return managerConnections.getPopularMovies()
    }
    
    func makeDetailView(movieID: Int) {
        router?.navigateToDetailView(movieID: movieID)
    }
}
