//
//  FriendSearchViewController.swift
//  MultiTask Tracker
//
//  Created by Zhansen Zhalel on 17.08.2024.
//

import UIKit

class FriendSearchViewController: UIViewController {
    var searchField = MTTextField()
    var searchButton = UIButton()
    var profileView = UIView()
    var user: MTUser!
    
    var profileViewController = FriendProfileViewController(user: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureSearchField()
        configureSearchButton()
        configureProfileView()
        configureProfileViewController()
        profileViewController.contentUnavailableConfiguration = UIContentUnavailableConfiguration.empty()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc private func dismissViewController() {
        dismiss(animated: true)
    }
    
    private func configureSearchField() {
        view.addSubview(searchField)
        searchField.delegate = self
        
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
        searchButton = UIButton.systemButton(with: UIImage(systemName: "magnifyingglass")!, target: self, action: #selector(loadUser))
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
    
    private func configureProfileView() {
        view.addSubview(profileView)
        profileView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 15),
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            profileView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureProfileViewController() {
        addChild(profileViewController)
        profileView.addSubview(profileViewController.view)
        profileViewController.view.frame = profileView.bounds
        profileViewController.didMove(toParent: self)
    }
    
    @objc private func loadUser() {
        profileViewController.contentUnavailableConfiguration = UIContentUnavailableConfiguration.loading()
        Task {
            user = await NetworkManager.shared.getUser(withName: searchField.text!)
            
            if let user {
                profileViewController.user = user
            }
            profileViewController.setNeedsUpdateContentUnavailableConfiguration()
        }
    }
}

#Preview {
    FriendSearchViewController()
}

extension FriendSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loadUser()
        return true
    }
}
