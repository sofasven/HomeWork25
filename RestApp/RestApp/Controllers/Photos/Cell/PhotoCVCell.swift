//
//  PhotoCVCell.swift
//  RestApp
//
//  Created by Sofa on 18.10.23.
//

import UIKit
import Alamofire
import AlamofireImage

class PhotoCVCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var thumbnailUrl: String? {
        didSet {
            getThumbnail()
        }
    }
    
    private func getThumbnail() {
        guard let thumbnailUrl = thumbnailUrl else { return }
        NetworkService.getThumbnail(thumbnailURL: thumbnailUrl) { [weak self] image, error in
            self?.activityIndicatorView.stopAnimating()
            self?.imageView.image = image
        }
    }

}
