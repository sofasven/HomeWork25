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
//    func createContextMenu() {
//        let contextMenu = UIContextMenuInteraction(delegate: self)
//        imageView.isUserInteractionEnabled = true
//        imageView.addInteraction(contextMenu)
//    }
}

//extension PhotoCVCell: UIContextMenuInteractionDelegate {
//    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
//        return UIContextMenuConfiguration(actionProvider:  { _ in
//            let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash.slash"), attributes: .destructive) { _ in
//                print("delete")
//            }
//            return UIMenu(title: "Menu", children: [delete])
//        })
//    }
//
//
//}
