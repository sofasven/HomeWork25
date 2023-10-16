//
//  CommentsTVC.swift
//  RestApp
//
//  Created by Sofa on 16.10.23.
//

import UIKit

class CommentsTVC: UITableViewController {
    
    var postId: Int?
    var comments: [Comments] = []
    
    override func viewWillAppear(_ animated: Bool) {
        fetchComments()
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let comment = comments[indexPath.row]
        cell.textLabel?.text = "\(comment.email ?? "")\n\(comment.name ?? "")"
        cell.detailTextLabel?.text = comment.body
        return cell
    }
    
    private func fetchComments() {
        guard let postId = postId else { return }
        let urlPath = "\(ApiConstants.commentsPath)?postId=\(postId)"
        guard let url = URL(string: urlPath) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data else { return }
            do {
                self?.comments = try JSONDecoder().decode([Comments].self, from: data)
            } catch let error {
                print(error)
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        task.resume()
    }
}
