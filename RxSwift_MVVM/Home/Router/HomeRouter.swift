//
//  HomeRouter.swift
//  RxSwift_MVVM
//
//  Created by Sailor on 11/06/2020.
//  Copyright © 2020 com.sailor. All rights reserved.
//
// Creara el objeto Home y servira de Router para moverse entre pantallas
import Foundation
import UIKit

class HomeRouter{
    //inicializador de clase
    
    var viewController: UIViewController{
        return createViewController()
    }
    
    var sourceView: UIViewController?
    
    private func createViewController() -> UIViewController{
        let view = HomeViewController(nibName: "HomeViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView: UIViewController?){
        guard let view = sourceView else {fatalError("Error desconocido")}
        self.sourceView = view
    }
    
    func navigateToDetailView(movieID: Int) {
        let detailViewRouter = DetailRouter(movieID: movieID).viewController
        sourceView?.navigationController?.pushViewController(detailViewRouter, animated: true)
    }
}
