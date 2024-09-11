//
//  FriendSearchViewController.swift
//  MultiTask Tracker
//
//  Created by Zhansen Zhalel on 17.08.2024.
//

import UIKit

class FriendSearchViewController: UIViewController {
    var isFirstLoad = true
    var searchField = MTTextField()
    var searchButton = UIButton()
    var profileViewController = FriendProfileViewController(user: nil)
    
    var user: MTUser!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureSearchField()
        configureSearchButton()
    }
    
    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        var config: UIContentUnavailableConfiguration?
        if user == nil {
            if isFirstLoad {
                return
            }
            
            config = .search()
            config?.image = .init(systemName: "magnifyingglass")
            config?.text = "Couldn't find this user"
            
            searchField.isHidden = true
            searchButton.isHidden = true
        } else {
            config = .empty()
            profileViewController.view.isHidden = false
            searchField.isHidden = true
            searchButton.isHidden = true
        }
        
        contentUnavailableConfiguration = config
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
            searchField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10),
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
            searchButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    private func configureProfileViewController() {
        addChild(profileViewController)
        view.addSubview(profileViewController.view)
        profileViewController.didMove(toParent: self)
        
        profileViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profileViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            profileViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            profileViewController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        profileViewController.view.isHidden = true
    }
    
    @objc private func loadUser() {
        isFirstLoad = false
        searchField.isHidden = true
        searchButton.isHidden = true
        
        self.contentUnavailableConfiguration = UIContentUnavailableConfiguration.loading()
        
        Task {
            user = await NetworkManager.shared.getUser(withName: searchField.text!)
            
            if let user {
                profileViewController.user = user
            } else {
                profileViewController.user = nil
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
