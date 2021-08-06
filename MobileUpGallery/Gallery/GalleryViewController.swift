//
//  GalleryViewController.swift
//  MobileUpGallery
//
//  Created by Andrey Komarov on 8/5/21.
//

import UIKit
import SwiftyVK

class GalleryViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    let reusableCellId = "loadReuseId"
    let spacingBetweenCells: CGFloat = 2
    let numberOfItemsPerRow: CGFloat = 2
    var urlListHasBeenLoaded = false
    
    lazy var loadPhotosManager: LoadPhotosProtocol = LoadPhotosManager(for: self)
    var photos = [Photo]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Mobile Up Gallery"
        
//        logoutButton setting
        let logoutButton = UIBarButtonItem(title: "Выход", style: .plain, target: self, action: #selector(doLogout))
        logoutButton.tintColor = .black
        logoutButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .medium)], for: .normal)
        self.navigationItem.rightBarButtonItem  = logoutButton
        
//        collectionView setting
        collectionView.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: reusableCellId)
        collectionView.isHidden = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
        
        DispatchQueue.global(qos: .default).async {
            self.loadPhotos()
        }
    }
    

    func loadPhotos() {
      DispatchQueue.main.async {
        self.activityIndicator.startAnimating()
      }
      loadPhotosManager.loadPhotos { (success) -> Void in
        if success {
          DispatchQueue.main.async {
            self.collectionView.isHidden = false
            self.activityIndicator.stopAnimating()
            self.urlListHasBeenLoaded = true
            self.collectionView.reloadData()
          }
        } else {
          print(#function)
        }
      }
    }
    
    @objc func doLogout() {
        let alert = UIAlertController(title: nil, message: "Вы уверены, что хотите выйти?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Выйти", style: .destructive, handler: { _ in
            VK.sessions.default.logOut()
            alert.dismiss(animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource

extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        17
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableCellId, for: indexPath) as? GalleryCollectionViewCell
        guard let cellUnwrapped = cell else {
            return UICollectionViewCell()
        }
        if urlListHasBeenLoaded {
            let dataTaskForCell = loadPhotosManager.createUrlSessionDataTask(urlString: photos[indexPath.row].biggestSize.url, imageView: cellUnwrapped.loadedPhotoImageView)
            cellUnwrapped.curDataTask = dataTaskForCell
            dataTaskForCell?.resume()
        } else {
            cellUnwrapped.curImage = #imageLiteral(resourceName: "placeholder")
        }
        return cellUnwrapped
    }
    
//    TODO constants
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpacing = (numberOfItemsPerRow - 1) * spacingBetweenCells
        let width = (collectionView.bounds.width - totalSpacing) / numberOfItemsPerRow
        return CGSize(width: width, height: width)
    }
}

// MARK: - UICollectionViewDelegate

extension GalleryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let showPhotoVC = ShowPhotoViewController()
        showPhotoVC.photoUrl = photos[indexPath.row].biggestSize.url
        showPhotoVC.date = photos[indexPath.row].date
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .black
        navigationController?.pushViewController(showPhotoVC, animated: true)
    }
}
