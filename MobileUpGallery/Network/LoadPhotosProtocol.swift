//
//  LoadPhotosProtocol.swift
//  MobileUpGallery
//
//  Created by Andrey Komarov on 8/5/21.
//

import Foundation
import UIKit

protocol LoadPhotosProtocol {
    func loadPhotos(completion: @escaping (_ success: Bool) -> Void)
    func createUrlSessionDataTask(urlString: String, for imageView: UIImageView) -> URLSessionDataTask?
}
