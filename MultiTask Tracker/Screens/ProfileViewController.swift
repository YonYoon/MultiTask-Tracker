//
//  ProfileViewController.swift
//  MultiTask Tracker
//
//  Created by Алексей Волков on 10.07.2024.
//

import UIKit

class ProfileViewController: UIViewController {
    let signOutButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureSignOutButton()
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
