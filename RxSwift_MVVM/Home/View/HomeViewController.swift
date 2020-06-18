//
//  HomeViewController.swift
//  RxSwift_MVVM
//
//  Created by Sailor on 11/06/2020.
//  Copyright © 2020 com.sailor. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController, UISearchBarDelegate {

    private var router = HomeRouter()
    private var viewModel = HomeViewModel()
    private var disposeBag = DisposeBag() //recolector de basura
    private var movies = [Movie]()
    private var filteredMovies = [Movie]()
   
    lazy var searchController: UISearchController = ({
       let controller = UISearchController(searchResultsController: nil)
        controller.hidesNavigationBarDuringPresentation = true // al iniciar no esta seteado
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.sizeToFit()
        controller.searchBar.barStyle = .black
        controller.searchBar.backgroundColor = .clear
        controller.searchBar.placeholder = "Buscar una película"
        
        return controller
    })()
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    @IBOutlet weak var activityOutlet: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "The Movie App with RxSwitf"
        configureTableView()
        viewModel.bind(view: self, router: router)
        getData() //se extraen los datos al iniciar
        manageSearchBarController()
    }
    
    private func configureTableView(){
        tableViewOutlet.rowHeight = UITableView.automaticDimension //altura automatica
        tableViewOutlet.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
    }
    
    
    
    private func getData() {
        return viewModel.getListMoviesData()
            .subscribeOn(MainScheduler.instance) // se suscribe con RxSwift en el hilo principal
            .observeOn(MainScheduler.instance)
            //se suscribe al observable
            .subscribe(onNext: { movies in
                self.movies = movies
                self.reloadTableViewProc()
            }, onError: { error in
                print(error.localizedDescription)
            }, onCompleted: {
                // ya se recarga la tabla en la suscripcion de arriba
            }).disposed(by: disposeBag)
    }
    
    
    private func reloadTableViewProc(){
        //en el hilo principal
        DispatchQueue.main.async {
            self.activityOutlet.stopAnimating()
            self.activityOutlet.isHidden = true
            self.tableViewOutlet.reloadData()
        }
    }
    
    private func manageSearchBarController() {
        let searchBar = searchController.searchBar //instancio
        searchBar.delegate = self
        tableViewOutlet.tableHeaderView = searchBar //asigno
        tableViewOutlet.contentOffset = CGPoint(x: 0, y: searchBar.frame.size.height) //alto de buscador
        
        //RxCocoa, asocio la searchBar. Filtro con programacion reactiva
        searchBar.rx.text
        .orEmpty
        .distinctUntilChanged()
            .subscribe(onNext: { (result) in
                self.filteredMovies = self.movies.filter({ movie in
                    self.reloadTableViewProc()
                    return movie.title.contains(result) //filtra por result
                })
                
            })
        .disposed(by: disposeBag)
    }


}

extension HomeViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != ""{
            return self.filteredMovies.count
        }
        
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        //si esta buscando, uso filteredMovies
         if searchController.isActive && searchController.searchBar.text != "" {
            cell.imageViewOut.imageFromServerURL(urlString: "\(Constants.URL.urlImages + self.filteredMovies[indexPath.row].image)", placeHolderImage: UIImage(named: "clapper")!)
            cell.titleMovie.text = filteredMovies[indexPath.row].title
            cell.descriptionMovie.text = filteredMovies[indexPath.row].overView
         } else {
            cell.imageViewOut.imageFromServerURL(urlString: "\(Constants.URL.urlImages + self.movies[indexPath.row].image)", placeHolderImage: UIImage(named: "clapper")!)
            cell.titleMovie.text = movies[indexPath.row].title
            cell.descriptionMovie.text = movies[indexPath.row].overView
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         if searchController.isActive && searchController.searchBar.text != "" {
            viewModel.makeDetailView(movieID: self.filteredMovies[indexPath.row].MovieID)
        }
         else{
             viewModel.makeDetailView(movieID: self.movies[indexPath.row].MovieID)
        }
    }
    
    
}

extension HomeViewController: UISearchControllerDelegate {
    func searchBarCancelButtonCliked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        reloadTableViewProc()
    }
}
