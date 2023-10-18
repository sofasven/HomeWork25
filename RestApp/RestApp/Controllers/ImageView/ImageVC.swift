//
//  ImageVC.swift
//  RestApp
//
//  Created by Sofa on 11.10.23.
//

import UIKit

class ImageVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    private let imageURL = "https://greetcard.ru/uploads/posts/2022-07/1657870668_kartinka-privet-7.jpg"
    private let imageURL2 = "https://w.forfun.com/fetch/29/2942cda3da91073bcaf9915bec9195d5.jpeg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
    }
    
    private func fetchImage() {
        
        guard let url = URL(string: imageURL2) else { return }
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            
            DispatchQueue.main.async {
                
                self?.activityIndicatorView.stopAnimating()
                
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                if let data = data,
                let image = UIImage(data: data) {
                    self?.imageView.image = image
                }
            }
        }
        task.resume()
    }
}
