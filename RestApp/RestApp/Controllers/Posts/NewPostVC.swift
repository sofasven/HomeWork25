//
//  NewPostVC.swift
//  RestApp
//
//  Created by Sofa on 15.10.23.
//

import UIKit
import SwiftyJSON

class NewPostVC: UIViewController {
    
    var user: User?
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var bodyTV: UITextView!
    
    
    @IBAction func postAction() {
        if let userId = user?.id,
           let title = titleTF.text,
           let body = bodyTV.text,
           let url = ApiConstants.postsURL {
            ///setup request
            var request = URLRequest(url: url)
            /// header
            request.httpMethod = Methods.post.rawValue
            request.addValue("application/json", forHTTPHeaderField: "Content-type")
            /// body
            let postBodyJSON: [String: Any] = ["userId": userId,
                                               "title": title,
                                               "body": body]
            let httpBody = try? JSONSerialization.data(withJSONObject: postBodyJSON)
            request.httpBody = httpBody
            /// create dataTask and send new post
            URLSession.shared.dataTask(with: request) { [weak self] data, _, _ in
                if let data = data {
                    let json = JSON(data)
                    let userId = json["userId"]
                    let title = json["title"]
                    let body = json["body"]
                    DispatchQueue.main.async {
                        self?.navigationController?.popViewController(animated: true)
                    }
                }
            }.resume()
        }
    }
    
    

}
