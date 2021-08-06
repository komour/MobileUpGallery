//
//  LoadPhotosManager.swift
//  MobileUpGallery
//
//  Created by Andrey Komarov on 8/5/21.
//

import Foundation
import SwiftyVK

class LoadPhotosManager: LoadPhotosProtocol {
    
    private var galleryViewController: GalleryViewController
    
    init (for viewController: GalleryViewController) {
        self.galleryViewController = viewController
    }
    
    private enum RequestError: Error {
        case networkError
        case parsingError
    }
    
    func loadPhotos(completion: @escaping (Bool) -> Void) {
        requestPhotos { result in
            switch result {
            case .failure(let error):
                print("Error loading photos in \(#function): \(error)")
                completion(false)
            case .success:
                completion(true)
            }
        }
    }
    
    private func requestPhotos(completion: @escaping(Result<Bool, RequestError>) -> Void) {
        VK.API.Photos.get([
            .ownerId: "-128666765",
            .albumId: "266276915",
            .photoSizes: "1",
            .rev: "0",
            .offset: "0",
            .count: "17"
        ]).onSuccess { response in
            do {
                let responseDecoded = try JSONDecoder().decode(GetPhotosResponse.self, from: response)
                self.galleryViewController.photos = responseDecoded.items
                completion(.success(true))
            } catch let parsingError {
                completion(.failure(.parsingError))
                print("Parsing error in \(#function): \(parsingError)")
            }
        }.onError { (error) in
            print("Request failed with error: \(error)")
            completion(.failure(.networkError))
        }.send()
    }
    
    func createUrlSessionDataTask(urlString: String, for imageView: UIImageView) -> URLSessionDataTask? {
        guard let url = URL(string: urlString) else {
            print("nil url in \(#function)")
            return nil
        }
        return URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) in
            if let error = error {
                print("Error in \(#function): \(error)")
                return
            }
            if let data = data {
                DispatchQueue.main.async {
                    imageView.image = UIImage(data: data)
                }
            } else {
                print("nil data in \(#function)")
            }
        })
    }
}
