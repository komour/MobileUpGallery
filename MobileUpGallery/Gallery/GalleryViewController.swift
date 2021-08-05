//
//  GalleryViewController.swift
//  MobileUpGallery
//
//  Created by Andrey Komarov on 8/5/21.
//

import UIKit

class GalleryViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    let reusableCellId = "loadReuseId"
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 2.5, left: 2.5, bottom: 2.5, right: 2.5)
        layout.minimumLineSpacing = 2.5
        layout.minimumInteritemSpacing = 2.5
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        
//        TODO constants
        cv.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: "loadReuseId")
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Mobile Up Gallery"
        
//        logoutButton setting
        let logoutButton = UIBarButtonItem(title: "Выход", style: .plain, target: self, action: #selector(doLogout))
        logoutButton.tintColor = .black
        logoutButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .medium)], for: .normal)
        self.navigationItem.rightBarButtonItem  = logoutButton
        
//        collectionView setting
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
    }
    
    @objc func doLogout() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource

extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableCellId, for: indexPath) as? GalleryCollectionViewCell
        guard let cellUnwrapped = cell else {
            return UICollectionViewCell()
        }
        cellUnwrapped.curImage = #imageLiteral(resourceName: "placeholder")
        
        return cellUnwrapped
    }
    
//    TODO constants
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow: CGFloat = 2
        let spacing: CGFloat = 2.5
        let spacingBetweenCells: CGFloat = spacing
        let totalSpacing = (2 * spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells)
        let width = (collectionView.bounds.width - totalSpacing) / numberOfItemsPerRow
        return CGSize(width: width, height: width)
    }
}

// MARK: - UICollectionViewDelegate

extension GalleryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let showPhotoVC = ShowPhotoViewController()
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .black
        navigationController?.pushViewController(showPhotoVC, animated: true)
        print(#function, indexPath)
    }
}
