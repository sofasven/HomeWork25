//
//  CreateNewToDoVC.swift
//  RestApp
//
//  Created by Sofa on 15.10.23.
//

import UIKit
import Alamofire
import SwiftyJSON

class CreateNewToDoVC: UIViewController {
    
    var user: User?
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var completedSC: UISegmentedControl!
    
    
    @IBAction func createToDoAction() {
        if let userId = user?.id,
           let title = titleTF.text
        {
            let completed = completedSC.selectedSegmentIndex == 0
            print(completed)
            let parameters: Parameters = ["userId": userId,
                                          "title": title,
                                          "completed": completed]
            AF.request(ApiConstants.toDosPath, method: .post, parameters: parameters, encoding: JSONEncoding.default)
                .response { [weak self] response in
                    debugPrint(response.result)
                            
                    switch response.result {
                    case .success(let data):
                        print(data)
                        self?.navigationController?.popViewController(animated: true)
                    case .failure(let error):
                        print(error)
                    }
                }
        } else { print("error") }
    }

}
