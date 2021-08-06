//
//  UIImageView+load.swift
//  MobileUpGallery
//
//  Created by Andrey Komarov on 8/5/21.
//

import UIKit

extension UIImageView {
    func loadImageUsingUrlString(urlString: String) {
        guard let url = URL(string: urlString) else {
            print("nil url in \(#function)")
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) in
            if let error = error {
                print("Error in \(#function): \(error)")
                return
            }
            if let data = data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            } else {
                print("nil data in \(#function)")
            }
        }).resume()
    }
}
