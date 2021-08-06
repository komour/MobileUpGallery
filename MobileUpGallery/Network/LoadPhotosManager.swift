//
//  LoadPhotosManager.swift
//  MobileUpGallery
//
//  Created by Andrey Komarov on 8/5/21.
//

import Foundation
import SwiftyVK

class LoadPhotosManager: LoadPhotosProtocol {
    
    var viewController: GalleryViewController?
    
    init (for viewController: GalleryViewController) {
      self.viewController = viewController
    }
    
    private enum RequestError: Error {
      case networkError
      case wrongUrl
      case parsingError
    }
    
    func loadPhotos(completion: @escaping (Bool) -> Void) {
        requestPhotos { result in
          switch result {
          case .failure(let error):
            print(error)
          case .success:
            completion(true)
          }
        }
    }
    
    private func requestPhotos(completion: @escaping(Result<Bool, RequestError>) -> Void) {
      guard let vc = viewController else {
        print("nil LoadPhotosVC in \(#function)")
        return
      }

        VK.API.Photos.get([
            .ownerId: "-128666765",
            .albumId: "266276915",
            .photoSizes: "1",
            .rev: "0",
            .offset: "0",
            .count: "17"
        ]).onSuccess { response in
            do {
//                print(String(data: response, encoding: .utf8))
                let responseDecoded = try JSONDecoder().decode(GetPhotosResponse.self, from: response)
                print(responseDecoded.count)
                vc.photos = responseDecoded.items
                completion(.success(true))
            } catch let parsingError {
                completion(.failure(.parsingError))
                print("Error", parsingError)
            }
        }.onError { (error) in
            print("Request failed with error: \(error)")
        }.send()
    }
    
    func createUrlSessionDataTask(urlString: String, imageView: UIImageView) -> URLSessionDataTask? {
        let url = URL(string: urlString)
        guard let urlUnwrapped = url else {
            print("nil url in \(#function)")
            return nil
        }
        
        return URLSession.shared.dataTask(with: urlUnwrapped, completionHandler: { (data, _, error) in
            if let error = error {
                print(error)
                return
            }
            guard let dataUnwrapped = data else {
                print("nil data in \(#function)")
                return
            }
            DispatchQueue.main.async {
                imageView.image = UIImage(data: dataUnwrapped)
            }
        })
    }
}
