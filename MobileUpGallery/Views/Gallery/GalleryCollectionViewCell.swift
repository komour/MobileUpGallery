//
//  GalleryCollectionViewCell.swift
//  MobileUpGallery
//
//  Created by Andrey Komarov on 8/5/21.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    let loadedPhotoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "placeholder")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    var curDataTask: URLSessionDataTask?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpImageView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        loadedPhotoImageView.image = #imageLiteral(resourceName: "placeholder")
        curDataTask?.cancel()
    }
    
    func setUpImageView() {
        contentView.addSubview(loadedPhotoImageView)
        loadedPhotoImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        loadedPhotoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        loadedPhotoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        loadedPhotoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}