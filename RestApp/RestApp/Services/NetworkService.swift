//
//  NetworkService.swift
//  RestApp
//
//  Created by Sofa on 16.10.23.
//

import Foundation
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
    
}

