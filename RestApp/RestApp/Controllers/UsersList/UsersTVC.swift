//
//  UsersTVC.swift
//  RestApp
//
//  Created by Sofa on 11.10.23.
//

import UIKit

class UsersTVC: UITableViewController {
    
    var users: [User] = []
    
    override func viewWillAppear(_ animated: Bool) {
        fetchUsers()
    }
    
    
    @IBAction func addUser(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addUser", sender: nil)
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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { true }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let userId = users[indexPath.row].id
            NetworkService.deleteUser(userId: userId) { [weak self] in
                self?.users.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }

    
     // MARK: - Navigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        let stor = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = stor.instantiateViewController(withIdentifier: "DetailVC") as? DetailVC else { return }
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
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
