//
//  FriendSearchViewController.swift
//  MultiTask Tracker
//
//  Created by Zhansen Zhalel on 17.08.2024.
//

import UIKit

class FriendSearchViewController: UIViewController {
    var searchField = MTTextField()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        configureSearchField()
    }
    
    private func configureSearchField() {
        view.addSubview(searchField)
        
        searchField.translatesAutoresizingMaskIntoConstraints = false
        searchField.autocorrectionType = .no
        searchField.autocapitalizationType = .none
        searchField.placeholder = "Username"
        
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchField.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}

#Preview {
    FriendSearchViewController()
}
