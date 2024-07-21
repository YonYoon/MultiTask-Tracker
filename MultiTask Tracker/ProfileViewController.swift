//
//  ProfileViewController.swift
//  MultiTask Tracker
//
//  Created by cloud on 21.07.2024.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let avatarView = UIImageView(image: UIImage(named: "avatar"))
    
    var tableView = UITableView(frame: .zero, style: .grouped)
    var dataSource = [
        ["Edit Profile", "Dark Theme", "Notifications"],
        ["Language", "Private Agreement", "Pin Lock"],
        ["Our Team", "Log Out"]
    ]
    
    let nameLabel = UILabel()
    
    let emailLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureAvatarView()
        configureTableView()
    }
    
    func configureAvatarView() {
        view.addSubview(avatarView)
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            avatarView.heightAnchor.constraint(equalToConstant: 100),
            avatarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 150),
            avatarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -150)
        ])
    }
    
    func configureTableView() {
        view.addSubview(tableView)
                let editProfileImage = UIImage(systemName: "person")
                let darkThemeImage = UIImage(systemName: "paintbrush.pointed")
                let notificationsImage = UIImage(systemName: "bell.badge")
        
        
        
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 109),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        self.view.addSubview(nameLabel)
        nameLabel.text = "NAME"
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        nameLabel.adjustsFontForContentSizeCategory = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        NSLayoutConstraint.activate([
            
            nameLabel.topAnchor.constraint(equalTo: avatarView.topAnchor, constant: 10),
            nameLabel.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: 75),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 170),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -150)]
        )
        
        
        self.view.addSubview(emailLabel)
        emailLabel.text = "example@gmail.com"
        emailLabel.font = UIFont.preferredFont(forTextStyle: .body)
        emailLabel.adjustsFontForContentSizeCategory = true
        emailLabel.font = emailLabel.font.withSize(12)
        
        
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        NSLayoutConstraint.activate([
            
            emailLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 35),
            emailLabel.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: 10),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 140),
            emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -110)]
                                    
        )}
    
}


extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var configuration = cell.defaultContentConfiguration()
        configuration.text = dataSource[indexPath.section][indexPath.row]
        
        var backgroundConfiguration = cell.backgroundConfiguration
        backgroundConfiguration?.backgroundColor = .systemGray5
        
        cell.contentConfiguration = configuration
        cell.backgroundConfiguration = backgroundConfiguration
        
        return cell
    }
}


