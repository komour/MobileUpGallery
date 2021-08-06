//
//  GalleryCollectionViewCell.swift
//  MobileUpGallery
//
//  Created by Andrey Komarov on 8/5/21.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    var curImage: UIImage = #imageLiteral(resourceName: "placeholder") {
        didSet {
            loadedPhotoImageView.image = curImage
        }
    }
    
    var curDataTask: URLSessionDataTask?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        curImage = #imageLiteral(resourceName: "placeholder")
        curDataTask?.cancel()
    }
    
    let loadedPhotoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "placeholder")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
