//
//  NetworkService.swift
//  RestApp
//
//  Created by Sofa on 16.10.23.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class NetworkService {
    static func deletePost(postId: Int, callback: @escaping () -> ()) {
           let urlPath = "\(ApiConstants.postsPath)/\(postId)"
            AF.request(urlPath, method: .delete, encoding: JSONEncoding.default)
            .response { response in
                callback()
        }
    }
    
    static func deleteToDo(toDoId: Int, callBack: @escaping () -> ()) {
        let urlPath = "\(ApiConstants.toDosPath)/\(toDoId)"
        AF.request(urlPath, method: .delete, encoding: JSONEncoding.default)
        .response { response in
            callBack()
        }
    }
    
    static func deleteUser(userId: Int, callBack: @escaping () -> ()) {
        let urlPath = "\(ApiConstants.usersPath)/\(userId)"
        AF.request(urlPath, method: .delete, encoding: JSONEncoding.default)
        .response { response in
            callBack()
        }
    }
    
    static func deleteImage(photoId: Int, callBack: @escaping () -> ()) {
        let urlPath = "\(ApiConstants.photosPath)/\(photoId)"
        AF.request(urlPath, method: .delete, encoding: JSONEncoding.default)
            .response { response in
                callBack()
            }
    }
    
    static func fetchAlbums(userID: Int, callback: @escaping (_ result: [Album]?, _ error: Error?) -> ()) {
        
        let urlPath = "\(ApiConstants.albumPath)?userId=\(userID)"
        
        AF.request(urlPath, method: .get, encoding: JSONEncoding.default)
            .response { response in

                var value: [Album]?
                var err: Error?

                switch response.result {
                case .success(let data):
                    guard let data = data else {
                        callback(value, err)
                        return
                    }
                    do {
                        value = try JSONDecoder().decode([Album].self, from: data)
                    } catch (let decoderError) {
                        callback(value, decoderError)
                    }
                case .failure(let error):
                    err = error
                }
                callback(value, err)
            }
    }
    static func fetchPhotos(albumID: Int, callback: @escaping (_ result: [Photo]?, _ error: Error?) -> ()) {
        
        let urlPath = "\(ApiConstants.photosPath)?albomId=\(albumID)"
        
        AF.request(urlPath, method: .get, encoding: JSONEncoding.default)
            .response { response in

                var value: [Photo]?
                var err: Error?

                switch response.result {
                case .success(let data):
                    guard let data = data else {
                        callback(value, err)
                        return
                    }
                    do {
                        value = try JSONDecoder().decode([Photo].self, from: data)
                    } catch (let decoderError) {
                        callback(value, decoderError)
                    }
                case .failure(let error):
                    err = error
                }
                callback(value, err)
            }
    }
    
    static func getThumbnail(thumbnailURL: String, callback: @escaping (_ result: UIImage?, _ error: AFError?) -> ()) {
        AF.request(thumbnailURL).responseImage { response in
            switch response.result {
                case .success(let image): callback(image, nil)
                case .failure(let error): callback(nil, error)
            }
        }
    }
    
    static func getData(from url: URL, complition: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: complition).resume()
    }
    
    static func downloadImage(from url: URL, callback: @escaping (_ image: UIImage?, _ error: Error?) -> ()) {
        getData(from: url) { data, response, error in
            if let data,
               let image = UIImage(data: data) {
                callback(image, nil)
            } else {
                callback(nil, error)
            }
        }
    }
    
}

