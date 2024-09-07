//
//  FriendSearchViewController.swift
//  MultiTask Tracker
//
//  Created by Zhansen Zhalel on 17.08.2024.
//

import UIKit

class FriendSearchViewController: UIViewController {
    var searchField = MTTextField()
    var searchButton = UIButton.systemButton(with: UIImage(systemName: "magnifyingglass")!, target: self, action: #selector(configureProfileViewController))
    var profileView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        
        configureSearchField()
        configureSearchButton()
    }
    
    private func configureSearchField() {
        view.addSubview(searchField)
        
        searchField.translatesAutoresizingMaskIntoConstraints = false
        searchField.autocorrectionType = .no
        searchField.autocapitalizationType = .none
        searchField.placeholder = "Type your friend's username"
        
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchField.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    private func configureSearchButton() {
        view.addSubview(searchButton)
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.setTitle("Search", for: .normal)
        searchButton.configuration = UIButton.Configuration.filled()
        searchButton.configuration?.cornerStyle = .capsule
        
        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 15),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}

#Preview {
    FriendSearchViewController()
}
