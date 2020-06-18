//
//  DetailRouter.swift
//  RxSwift_MVVM
//
//  Created by Sailor on 16/06/2020.
//  Copyright © 2020 com.sailor. All rights reserved.
//

import Foundation
import UIKit

class DetailRouter {
    //inicializador de clase
     
     var viewController: UIViewController{
         return createViewController()
     }
     
     var movieID: Int?
     var sourceView: UIViewController?
    
    init(movieID: Int? = 0 ) {
        self.movieID = movieID
    }
     
     private func createViewController() -> UIViewController{
         let view = DetailViewController(nibName: "DetailViewController", bundle: Bundle.main)
         view.movieID = self.movieID //seteo el movieID sino se envia null
         return view
     }
     
     func setSourceView(_ sourceView: UIViewController?){
         guard let view = sourceView else {fatalError("Error desconocido")}
         self.sourceView = view
     }
}
