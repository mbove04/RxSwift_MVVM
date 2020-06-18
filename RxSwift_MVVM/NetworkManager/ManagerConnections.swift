//
//  ManagerConnections.swift
//  RxSwift_MVVM
//
//  Created by Sailor on 11/06/2020.
//  Copyright © 2020 com.sailor. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

class ManagerConnections{
    
    // los get a la API a traves de RxSwift y URLSession
    func getPopularMovies() -> Observable<[Movie]> {
        
        return Observable.create { observer in
            let session = URLSession.shared
            var request = URLRequest(url: URL(string: Constants.URL.main + Constants.EndPoints.urlListPopularMovies + Constants.apiKey)!)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            session.dataTask(with: request) { (data,response,error) in
                guard let data = data, error == nil, let response = response as? HTTPURLResponse else {return}
                
                if response.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let movies = try decoder.decode(Movies.self, from: data)
                        observer.onNext(movies.listOfMovies) // se devuelven las movies
                       
                    } catch let error {
                        observer.onError(error)
                        print("Ha ocurrido un error:\(error)")
                    }
                }
                observer.onCompleted() //se finaliza el observer
            }.resume() //resume para que ejecute la llamada al server.
                //finalizar el disposable
                return Disposables.create{
                    session.finishTasksAndInvalidate()
                }
             }
    }
    
    
    
    func getDetailMovies(movieID: Int) -> Observable<MovieDetail> {
        return Observable.create { observer in
        let session = URLSession.shared
       
        var request = URLRequest(url: URL(string: Constants.URL.main + Constants.EndPoints.urlDetailMovie + String(movieID) + Constants.apiKey)!)

        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        session.dataTask(with: request) { (data,response,error) in
            guard let data = data, error == nil, let response = response as? HTTPURLResponse else {return}
    
            if response.statusCode == 200 {
                do {
                    let json = try? JSON(data:data)
                    let detailMovie = MovieDetail(jsonString: json?.description ?? "")
                    
                    //let decoder = JSONDecoder()
                    //let detailMovie = try decoder.decode(MovieDetail.self, from: data)
                    observer.onNext(detailMovie!)
                   
                } catch let error {
                    observer.onError(error)
                    print("Ha ocurrido un error:\(error.localizedDescription)")
                }
            }
            observer.onCompleted() //se finaliza el observer
        }.resume() //resume para que ejecute la llamada al server.
            //finalizar el disposable
            return Disposables.create{
                session.finishTasksAndInvalidate()
            }
         }
    }
}
