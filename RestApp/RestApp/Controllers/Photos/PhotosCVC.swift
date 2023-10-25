//
//  PhotosCVC.swift
//  RestApp
//
//  Created by Sofa on 18.10.23.
//

import UIKit
import Alamofire

class PhotosCVC: UICollectionViewController {
    
    var album: Album?
    var photos: [Photo]?

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
        return photos?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoCVCell
        let photo = photos?[indexPath.row]
        cell.thumbnailUrl = photo?.thumbnailUrl
        let interaction = UIContextMenuInteraction(delegate: self)
        cell.addInteraction(interaction)
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = photos?[indexPath.row]
        let vc = PhotoVC()
        vc.photo = photo
        self.present(vc, animated: true)
    }
    
}

extension PhotosCVC: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        guard let indexPath = collectionView.indexPathForItem(at: location) else { return nil }
        
        let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"), identifier: nil, attributes: .destructive) { [weak self] _ in
            self?.deletePhoto(at: indexPath)
        }
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            UIMenu(title: "", children: [delete])
        }
    }
    
    private func deletePhoto(at indexPath: IndexPath) {
        
        guard let collectionView = collectionView,
              let photo = photos?[indexPath.item] else { return }
            let photoId = photo.id
            let urlString = "\(ApiConstants.photosPath)/\(photoId)"
            guard let url = URL(string: urlString) else { return }
            
            AF.request(url, method: .delete).response { [weak self] response in
                switch response.result {
                case .success:
                    // Удаляем фото из источника данных
                    self?.photos?.remove(at: indexPath.item)
                    
                    // Удаляем ячейку из коллекции
                    collectionView.deleteItems(at: [indexPath])
                    
                case .failure(let error):
                    print("Не удалось удалить фото: \(error)")
                }
            }
        }
    }
