//
//  DetailVC.swift
//  RestApp
//
//  Created by Sofa on 11.10.23.
//

import UIKit
import MapKit

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
    
    
    @IBAction func openMapBtn(_ sender: UIButton) { openMapsForUserLocation() }
    
    @IBAction func openPostFlow() {
        let storyboard = UIStoryboard(name: "PostFlow", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PostsTVC") as! PostsTVC
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func openAlbumFlow() {
        let storyboard = UIStoryboard(name: "AlbumsAndPhotosFlow", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AlbumsTVC") as! AlbumsTVC
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func openToDoFlow() {
        let storyboard = UIStoryboard(name: "ToDoFlow", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ToDoTVC") as! ToDoTVC
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupUI() {
        nameLbl.text = user?.name
        userNameLbl.text = user?.username
        emailLbl.text = user?.email
        phoneLbl.text = user?.phone
        websaitLbl.text = user?.website
    }
    
    private func openMapsForUserLocation() {
        if let user = user,
           let latitudeString = user.address?.geo?.lat,
           let longitudeString = user.address?.geo?.lng,
           let latitude = Double(latitudeString),
           let longitude = Double(longitudeString) {
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let placemark = MKPlacemark(coordinate: coordinate)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = user.name
            mapItem.openInMaps()
        }
    }
}
