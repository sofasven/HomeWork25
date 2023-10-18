//
//  CreateUserVC.swift
//  RestApp
//
//  Created by Sofa on 16.10.23.
//

import UIKit
import SwiftyJSON

class CreateUserVC: UIViewController {
    ///user
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var websaitTF: UITextField!
    ///adress
    @IBOutlet weak var streetTF: UITextField!
    @IBOutlet weak var suiteTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var zipcodeTF: UITextField!
    /// Geo
    @IBOutlet weak var latTF: UITextField!
    @IBOutlet weak var lngTF: UITextField!
    /// Company
    @IBOutlet weak var companyNameTF: UITextField!
    @IBOutlet weak var catchPhraseTF: UITextField!
    @IBOutlet weak var companyBsTF: UITextField!
    
    
    @IBAction func addUserAction() {
        if let name = nameTF.text,
           let username = userNameTF.text,
           let email = emailTF.text,
           let phone = phoneTF.text,
           let websait = websaitTF.text,
           let street = streetTF.text,
           let suite = suiteTF.text,
           let city = cityTF.text,
           let zipcode = zipcodeTF.text,
           let lat = latTF.text,
           let lng = lngTF.text,
           let companyName = companyNameTF.text,
           let catchPhrase = catchPhraseTF.text,
           let bs = companyBsTF.text,
           let url = ApiConstants.usersURL {
            
            var request = URLRequest(url: url)
            request.httpMethod = Methods.post.rawValue
            request.addValue("application/json", forHTTPHeaderField: "Content-type")
            let geo: [String: Any] = ["lat": lat,
                                      "lng": lng]
            let adress: [String: Any] = ["street": street,
                                         "suite": suite,
                                         "city": city,
                                         "zipcode": zipcode,
                                         "geo": geo]
            let company: [String: Any] = ["name": companyName,
                                          "catchPhrase": catchPhrase,
                                          "bs": bs]
            let newUser: [String: Any] = ["name": name,
                                               "username": username,
                                               "email": email,
                                               "phone": phone,
                                               "website": websait,
                                          "adress": adress,
                                          "company": company]
            let httpBody = try? JSONSerialization.data(withJSONObject: newUser)
            request.httpBody = httpBody
            URLSession.shared.dataTask(with: request) { [weak self] data, _, _ in
                if let data = data {
                    let json = JSON(data)
                    DispatchQueue.main.async {
                        self?.navigationController?.popViewController(animated: true)
                    }
                }
            }.resume()
        }
           
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
