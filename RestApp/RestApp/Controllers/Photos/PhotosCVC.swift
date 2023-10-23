//
//  PhotosCVC.swift
//  RestApp
//
//  Created by Sofa on 18.10.23.
//

import UIKit

class PhotosCVC: UICollectionViewController {
    
    var album: Album?
    var photos: [Photo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "PhotoCVCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        fetchPhotos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let layout = UICollectionViewFlowLayout()
        let sizeWH = UIScreen.main.bounds.width / 2 - 5
        layout.itemSize = CGSize(width: sizeWH, height: sizeWH)
        collectionView.collectionViewLayout = layout
    }

    // MARK: UICollectionViewDataSource


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoCVCell
        let photo = photos[indexPath.row]
        cell.thumbnailUrl = photo.thumbnailUrl
        return cell
    }

    private func fetchPhotos() {
        guard let album = album else { return  }
        NetworkService.fetchPhotos(albumID: album.id) { [weak self] photos, error in
            if let error = error {
                print(error)
            } else if let photos = photos {
                self?.photos = photos
                self?.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let contextMenu = UIContextMenuConfiguration(identifier: nil,
                                                     previewProvider: nil) { _ in
            
            let delete = UIAction(title: "Delete",
                                  image: UIImage(systemName: "trash.slash"),
                                  attributes: .destructive) { _ in
                print("Delete")
                let photoId = self.photos[indexPath.row].id
                NetworkService.deleteImage(photoId: photoId) { [weak self] in
                    self?.photos.remove(at: indexPath.row)
                    collectionView.deleteItems(at: [indexPath])
                }
            }
            
            return UIMenu(title: "",
                          image: nil,
                          identifier: nil,
                          options: UIMenu.Options.displayInline,
                          children: [delete])
        }
        return contextMenu
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        let vc = PhotoVC()
        vc.photo = photo
        self.present(vc, animated: true)
    }
    
}
