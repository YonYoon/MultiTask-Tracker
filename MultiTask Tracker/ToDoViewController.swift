//
//  ToDoViewController.swift
//  MultiTask Tracker
//
//  Created by Алексей Волков on 10.07.2024.
//

import UIKit

class ToDoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
// Task list storage
    var todos: [ToDoItem] = [ToDoItem(name: "Test todo item")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor (named: "background")
        
        view.addSubview(tableView)
        constraintTableView()
        configureTableView()
        
// Сreates an "Add" button in the top right corner of the screen that, when clicked, calls the `openAlert` function
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openAlert))
    }
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
// Full page constraint
    func constraintTableView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ])
    }
    
// Sets the current controller as the data source and table delegate, registers the cell type, and disables cell selection
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "todoCell")
        tableView.allowsSelection = false
    }
    
// MARK: - Alert
    
// Function for Alert (adds a new task to the list ToDo and updates the page)
    func addTodo(name: String) {
        todos.append(ToDoItem(name: name))
        tableView.reloadData()
        }

// Create Alert
    @objc func openAlert() {
        let alert = UIAlertController(title: "Create todo", message: "", preferredStyle: .alert)
        alert.addTextField()
        let saveButton = UIAlertAction(title: "Save", style: .default) { _ in
            if let textName = alert.textFields?.first?.text {
                self.addTodo(name: textName)
        }
    }
        alert.addAction(saveButton)
        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addAction(cancelButton)
            
        present(alert, animated: true)
    }
    
// MARK: - Table View Methods
    
// Returns the number of rows in the table (equal to the number of elements in `todos`).
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
// Returns the cell for the specified row in the table. Fills the cell with data from `todos`.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "todoCell")
        let todoItem = todos[indexPath.row]
        
        cell.textLabel?.text = todoItem.name
        cell.accessoryType = .checkmark
        
        return cell
    }
    
// Handles the action of deleting a row in a table. Removes a task from `todos` and updates the table.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
    
