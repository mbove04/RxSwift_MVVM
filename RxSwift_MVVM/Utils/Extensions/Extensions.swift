//
//  Extensions.swift
//  RxSwift_MVVM
//
//  Created by Sailor on 15/06/2020.
//  Copyright © 2020 com.sailor. All rights reserved.
//

import UIKit

extension UIImageView {
    func imageFromServerURL(urlString: String, placeHolderImage: UIImage) {
        if self.image == nil {
            self.image = placeHolderImage
        }
        
        URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, error) in
            if error != nil{
                return
            }
            DispatchQueue.main.async {
                guard let data = data else {return}
                let image = UIImage(data: data)
                self.image =  image
            }
        }.resume() //se llama al datatask
    }
}
