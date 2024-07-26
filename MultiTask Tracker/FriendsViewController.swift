//
//  FriendsViewController.swift
//  MultiTask Tracker
//
//  Created by Алексей Волков on 10.07.2024.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class FriendsViewController: UIViewController {
    var friends = [MTUser]()
    var friendsList: UITableView!
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()
        configureSearchController()
        configureFriendsList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let selectedIndexPath = friendsList.indexPathForSelectedRow {
            friendsList.deselectRow(at: selectedIndexPath, animated: true)
        }
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        
        navigationItem.title = "Friends"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        #if DEBUG
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFriendTapped))
        navigationItem.rightBarButtonItem = addButton
        #endif
        
        friends = PersistenceManager.shared.read()
    }
        
    @objc func addFriendTapped() {
        friends.append(MTUser(name: "Test", handle: "test"))
        db.document("users/username").setData([
            "name": "John",
            "handle": "@john"
        ])
        PersistenceManager.shared.write(friends: friends)
        friendsList.reloadData()
    }
    
    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"
        navigationItem.searchController = searchController
    }
    
    private func configureFriendsList() {
        friendsList = UITableView(frame: view.bounds)
        friendsList.register(UITableViewCell.self, forCellReuseIdentifier: "userCell")
        friendsList.dataSource = self
        friendsList.delegate = self
        
        view.addSubview(friendsList)
        friendsList.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension FriendsViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        // TODO: - Update search results
    }
}

extension FriendsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friends = PersistenceManager.shared.read()
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        
        var configuration = cell.defaultContentConfiguration()
        configuration.text = friends[indexPath.item].name
        cell.contentConfiguration = configuration
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friend = friends[indexPath.item]
        
        let destinationViewController = UserProfileViewController()
        destinationViewController.user = friend
        navigationController?.pushViewController(destinationViewController, animated: true)
    }
}
