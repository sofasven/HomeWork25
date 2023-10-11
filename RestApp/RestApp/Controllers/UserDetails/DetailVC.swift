//
//  DetailVC.swift
//  RestApp
//
//  Created by Sofa on 11.10.23.
//

import UIKit

class DetailVC: UIViewController {
    
    var user: User?
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var websaitLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    private func setupUI() {
        nameLbl.text = user?.name
        userNameLbl.text = user?.username
        emailLbl.text = user?.email
        phoneLbl.text = user?.phone
        websaitLbl.text = user?.website
    }
}
