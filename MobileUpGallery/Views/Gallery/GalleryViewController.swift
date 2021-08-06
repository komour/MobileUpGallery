//
//  GalleryViewController.swift
//  MobileUpGallery
//
//  Created by Andrey Komarov on 8/5/21.
//

import SwiftyVK
import UIKit

class GalleryViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    // MARK: - Public properties

    public var photos = [Photo]()
    public var photosHaveBeenLoaded = false

    // MARK: - Private properties

    private let reusableCellId = "loadReuseId"
    private let spacingBetweenCells: CGFloat = 2
    private let numberOfItemsPerRow: CGFloat = 2
    private lazy var loadPhotosManager: LoadPhotosProtocol = LoadPhotosManager(for: self)

    // MARK: - Subviews

    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTitle()
        setUpLogoutButton()
        setUpCollectionView()

        DispatchQueue.global(qos: .userInteractive).async {
            self.loadPhotos()
        }
    }

    // MARK: - Private methods

    private func loadPhotos() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        loadPhotosManager.loadPhotos { (success: Bool) -> Void in
            if success {
                DispatchQueue.main.async {
                    self.collectionView.isHidden = false
                    self.activityIndicator.stopAnimating()
                    self.photosHaveBeenLoaded = true
                    self.collectionView.reloadData()
                }
            } else {
                self.presentLoadPhotosErrorAlert()
                self.activityIndicator.stopAnimating()
                print("Fail loading photos in \(#function)")
            }
        }
    }

    private func setUpLogoutButton() {
        let logoutButton = UIBarButtonItem(title: LocalizedStrings.logout, style: .plain, target: self, action: #selector(presentLogoutAlert))
        logoutButton.tintColor = .black
        logoutButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .medium)], for: .normal)
        navigationItem.rightBarButtonItem = logoutButton
    }

    private func setUpCollectionView() {
        collectionView.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: reusableCellId)
        collectionView.isHidden = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
    }

    private func setUpTitle() {
        title = "Mobile Up Gallery"
    }

    private func presentLoadPhotosErrorAlert() {
        let alert = UIAlertController(title: LocalizedStrings.networkError,
                                      message: LocalizedStrings.checkAndRelogin,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: LocalizedStrings.ok, style: .default, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }

    // MARK: - UI Actions

    @objc private func presentLogoutAlert() {
        let alert = UIAlertController(title: nil, message: LocalizedStrings.areYouSureLogOut, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: LocalizedStrings.doLogOut, style: .destructive, handler: { _ in
            VK.sessions.default.logOut()
            alert.dismiss(animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: LocalizedStrings.cancel, style: .cancel, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource

extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableCellId, for: indexPath) as? GalleryCollectionViewCell
        guard let cellUnwrapped = cell else {
            fatalError("nil cell in \(#function)")
        }
        cellUnwrapped.loadedPhotoImageView.image = #imageLiteral(resourceName: "placeholder")
        if photosHaveBeenLoaded, let url = URL(string: photos[indexPath.row].biggestImage.url) {
            cellUnwrapped.loadedPhotoImageView.kf.setImage(with: url)
        }
        return cellUnwrapped
    }

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
        showPhotoVC.photoUrl = photos[indexPath.row].biggestImage.url
        showPhotoVC.date = photos[indexPath.row].date
        navigationItem.backButtonTitle = ""
        guard let navigationController = navigationController else {
            fatalError("nil navigationController in \(#function)")
        }
        navigationController.navigationBar.tintColor = .black
        navigationController.pushViewController(showPhotoVC, animated: true)
    }
}
