//
//  DetailViewController.swift
//  RxSwift_MVVM
//
//  Created by Sailor on 16/06/2020.
//  Copyright © 2020 com.sailor. All rights reserved.
//

import UIKit
import RxSwift

class DetailViewController: UIViewController {

    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var imageDetail: UIImageView!
    @IBOutlet private weak var descriptionDetail: UILabel!
    @IBOutlet private weak var releaseDate: UILabel!
    @IBOutlet private weak var rating: UILabel!
    
    @IBOutlet weak var popularity: UILabel!
    var movieID: Int?
    private var disposeBag = DisposeBag()
    private var router = DetailRouter()
    private var viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scroll.delegate = self
       getDataAndShowDetailMovie()
        //enlace del viewModel con la vista
       viewModel.bind(view: self, router: router)
    }

    func showMovieData(movie: MovieDetail) {
        //vuelvo al hilo principal
        DispatchQueue.main.async {
            self.titleLabel.text = movie.title
            self.imageDetail.imageFromServerURL(urlString: Constants.URL.urlImages + movie.poster_path!, placeHolderImage: UIImage(named: "clapper")!)
            self.descriptionDetail.text = movie.overview
            self.releaseDate.text = movie.release_date
            let rating = movie.vote_average
            let popularityNumber = movie.popularity
            self.rating.text = String(rating!)
            self.popularity.text = String(popularityNumber!)
        }
    }
    
    func getDataAndShowDetailMovie() {
        
        guard let idMovie = movieID else {return}
        return viewModel.getMovieData(movieID: idMovie).subscribe(
            onNext: { movie in
                self.showMovieData(movie: movie)
        },
            onError: { error in
                print("Error")
        },
            onCompleted: {
                
            }).disposed(by: disposeBag)
    }
    

}

extension DetailViewController: UIScrollViewDelegate {
    
}
