//
//  LoadPhotosManager.swift
//  MobileUpGallery
//
//  Created by Andrey Komarov on 8/5/21.
//

import Foundation
import SwiftyVK

class LoadPhotosManager: LoadPhotosProtocol {
    // MARK: - Private properties

    private var galleryViewController: GalleryViewController

    private enum RequestError: Error {
        case networkError
        case parsingError
    }

    private struct RequestParameters {
        static let ownerId = "-128666765"
        static let albumId = "266276915"
        static let photoSizes = "1"
        static let rev = "0"
        static let offset = "0"
        static let count = "17"
    }

    // MARK: - Inits

    init(for viewController: GalleryViewController) {
        galleryViewController = viewController
    }

    // MARK: - Public methods

    public func loadPhotos(completion: @escaping (Bool) -> Void) {
        requestPhotos { result in
            switch result {
            case let .failure(error):
                print("Error loading photos in \(#function): \(error)")
                completion(false)
            case .success:
                completion(true)
            }
        }
    }

    // MARK: - Private methods

    private func requestPhotos(completion: @escaping (Result<Bool, RequestError>) -> Void) {
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
        }.onError { error in
            print("Request failed with error: \(error)")
            completion(.failure(.networkError))
        }.send()
    }
}
