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
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchFriendTapped))
        navigationItem.rightBarButtonItem = searchButton
        #endif
        
        friends = PersistenceManager.shared.read()
    }
        
    @objc func searchFriendTapped() {
        // TODO: present friend search
        let destinationViewController = FriendSearchViewController()
        navigationController?.pushViewController(destinationViewController, animated: true)
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

extension FriendsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        friends = PersistenceManager.shared.read()
//        return friends.count
        
        // TODO: Get list of friends from firebase
        return 0
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
