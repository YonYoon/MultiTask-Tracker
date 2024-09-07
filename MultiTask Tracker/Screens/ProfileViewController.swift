//
//  ProfileViewController.swift
//  MultiTask Tracker
//
//  Created by Алексей Волков on 10.07.2024.
//

import UIKit

class ProfileViewController: UIViewController {
    let usernameLabel = UILabel()
    let signOutButton = UIButton(type: .system)
    let user = AuthenticationManager.shared.user
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureUsernameLabel()
        configureSignOutButton()
    }
    
    private func configureUsernameLabel() {
        view.addSubview(usernameLabel)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.text = user?.displayName ?? "No name"
        usernameLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            usernameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configureSignOutButton() {
        view.addSubview(signOutButton)
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        
        signOutButton.setTitle("Sign out", for: .normal)
        
        signOutButton.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signOutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            signOutButton.widthAnchor.constraint(equalToConstant: 100),
            signOutButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    @objc private func signOut() {
        AuthenticationManager.shared.signOut()
    }
}
