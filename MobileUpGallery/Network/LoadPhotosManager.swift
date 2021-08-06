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
    
    init(for viewController: GalleryViewController) {
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
            .ownerId: RequestParameters.ownerId,
            .albumId: RequestParameters.albumId,
            .photoSizes: RequestParameters.photoSizes,
            .rev: RequestParameters.rev,
            .offset: RequestParameters.offset,
            .count: RequestParameters.count
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
}

struct RequestParameters {
    static let ownerId = "-128666765"
    static let albumId = "266276915"
    static let photoSizes = "1"
    static let rev = "0"
    static let offset = "0"
    static let count = "17"
}
