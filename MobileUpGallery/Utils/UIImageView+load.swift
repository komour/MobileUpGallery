//
//  UIImageView+load.swift
//  MobileUpGallery
//
//  Created by Andrey Komarov on 8/5/21.
//

import UIKit

extension UIImageView {
  func loadImageUsingUrlString(urlString: String) {
    image = #imageLiteral(resourceName: "placeholder")
    
    let url = URL(string: urlString)
    guard let urlUnwrapped = url else {
      print("nil url in \(#function)")
      return
    }
    
    URLSession.shared.dataTask(with: urlUnwrapped, completionHandler: { (data, _, error) in
      if let error = error {
        print(error)
        return
      }
      guard let dataUnwrapped = data else {
        print("nil data in \(#function)")
        return
      }
      
      DispatchQueue.main.async {
        self.image = UIImage(data: dataUnwrapped)
      }
      }).resume()
  }
}
