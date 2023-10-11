//
//  UsersTVC.swift
//  RestApp
//
//  Created by Sofa on 11.10.23.
//

import UIKit

class UsersTVC: UITableViewController {
    
    var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsers()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.username
        return cell
    }
    
     // MARK: - Navigation
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         guard let detailVC = segue.destination as? DetailVC,
         let indexPath = tableView.indexPathForSelectedRow else { return }
         detailVC.user = users[indexPath.row]
     }
    
    private func fetchUsers() {
        guard let usersURL = ApiConstants.usersURL else { return }
        
        URLSession.shared.dataTask(with: usersURL) { [weak self] data, response, error in
            
            guard let self else { return }
            
            if let error = error {
                print(error)
            }
            
            if let data = data {
                do {
                    self.users = try JSONDecoder().decode([User].self, from: data)
                } catch {
                    print(error)
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.resume()
    }
}
