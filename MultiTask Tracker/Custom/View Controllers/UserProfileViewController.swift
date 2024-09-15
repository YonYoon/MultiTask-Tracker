//
//  UserProfileViewController.swift
//  MultiTask Tracker
//
//  Created by Zhansen Zhalel on 25.07.2024.
//

import UIKit

class UserProfileViewController: UIViewController {
    var user: MTUser!
    let nameLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureProfile()
    }
    
    private func configureProfile() {
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.text = user.name
        nameLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nameLabel.widthAnchor.constraint(equalToConstant: view.frame.width),
            nameLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
