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
    var sectionsData: [[String: Any]] = [["": ""]]

    
        
    
    let nameLabel = UILabel()
    
    let emailLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sectionsData = [
          [
                "title": "",
                "rows": [
                    ["title": "Edit Profile", "icon": UIImage(systemName: "person")!]
                    
                    
                ]
            ],
            [
                "title": "",
                "rows": [
                    ["title": "Dark Theme", "icon": UIImage(systemName: "paintbrush.pointed")!, "isSwitchSection": true],
                    ["title": "Notifications", "icon": UIImage(systemName: "bell")!, "isSwitchSection": true]
                    
                ]
            ],
          
          [
              "title": "",
              "rows": [
                  ["title": "Language", "icon": UIImage(systemName: "person.2.fill")!],
                  ["title": "Pin Lock", "icon": UIImage(systemName: "mappin.square")!]
                  
              ]
          ],
            [
                "title": "",
                "rows": [
                    ["title": "About", "icon": UIImage(systemName: "person.3")!],
                    ["title": "Log Out", "icon": UIImage(systemName: "arrow.down.right.square.fill")!]
                   
                ]
                
            ]
        ]
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
    

        
        view.backgroundColor = .systemBackground
        
        configureAvatarView()
        configureTableView()
        configureNameLabel()
        configureEmailLabel()
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")

    }
    
    func configureAvatarView() {
        view.addSubview(avatarView)
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        
         let avatarSize: CGFloat = 100
        
        NSLayoutConstraint.activate([
            avatarView.topAnchor.constraint(equalTo:
                view.safeAreaLayoutGuide.topAnchor, constant: 25),
            avatarView.heightAnchor.constraint(equalToConstant: avatarSize),
            avatarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarView.widthAnchor.constraint(equalToConstant: avatarSize)
        ])
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
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
    }
    
    func configureNameLabel() {
        view.addSubview(nameLabel)

        nameLabel.text = "NAME"
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        nameLabel.adjustsFontForContentSizeCategory = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            
            nameLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
    }
    func configureEmailLabel() {
        view.addSubview(emailLabel)
        emailLabel.text = "example@gmail.com"
        emailLabel.font = UIFont.preferredFont(forTextStyle: .body)
        emailLabel.adjustsFontForContentSizeCategory = true
        emailLabel.font = emailLabel.font.withSize(12)
        
        
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        emailLabel.textAlignment = .center
        
        
        NSLayoutConstraint.activate([
            
            emailLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 35),
            emailLabel.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: 5),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}


extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsData.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rows = sectionsData[section]["rows"] as? [[String: Any]] {
            return rows.count
        } else {
            return 0
        }
    }

        func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
            return UIView()
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell

            if let rowData = sectionsData[indexPath.section]["rows"] as? [[String: Any]],
               let title = rowData[indexPath.row]["title"] as? String {
                cell.configure(with: title,
                               icon: rowData[indexPath.row]["icon"] as? UIImage,
                               isSwitchSection: indexPath.section == 1)
            }

            return cell
        }

        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return sectionsData[section]["title"] as? String
        }
  

    }


  
        
    
        
        
    



