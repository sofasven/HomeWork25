//
//  ToDoTVC.swift
//  RestApp
//
//  Created by Sofa on 15.10.23.
//

import UIKit

class ToDoTVC: UITableViewController {
    
    var user: User?
    var toDos: [ToDos] = []

    override func viewWillAppear(_ animated: Bool) {
        fetchToDos()
    }
    
    @IBAction func addNewToDo(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "createNewToDo", sender: nil)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        toDos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let toDo = toDos[indexPath.row]
        cell.textLabel?.text = toDo.title
        cell.detailTextLabel?.text = toDo.completed?.description
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { true }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let toDoId = toDos[indexPath.row].id
            NetworkService.deleteToDo(toDoId: toDoId) { [weak self] in
                self?.toDos.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? CreateNewToDoVC {
            vc.user = user
        }
    }
    
    private func fetchToDos() {
        let userId = user?.id.description ?? ""
        let urlPath = "\(ApiConstants.toDosPath)?userId=\(userId)"
        guard let url = URL(string: urlPath) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self,
                  let data = data else { return }
            do {
                self.toDos = try JSONDecoder().decode([ToDos].self, from: data)
            } catch let error {
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
}
