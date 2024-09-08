//
//  FriendProfileViewController.swift
//  MultiTask Tracker
//
//  Created by Zhansen Zhalel on 30.08.2024.
//

import UIKit

class FriendProfileViewController: UIViewController {
    let avatarImageView = MTImageView(frame: .zero)
    let usernameLabel = UILabel()
    var addFriendButton = UIButton()
    
    var user: MTUser!
    
    init(user: MTUser!) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        var config: UIContentUnavailableConfiguration?
        if user == nil {
            config = .search()
            config?.image = .init(systemName: "magnifyingglass")
            config?.text = "Couldn't find this user"
        } else {
            configureAvatarImageView()
            configureUsernameLabel()
            configureAddFriendButton()
        }
        
        contentUnavailableConfiguration = config
    }
    
    private func configureAvatarImageView() {
        view.addSubview(avatarImageView)
        avatarImageView.tintColor = .lightGray
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    private func configureUsernameLabel() {
        view.addSubview(usernameLabel)
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        usernameLabel.textAlignment = .natural
        usernameLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        usernameLabel.textColor = .label
        usernameLabel.adjustsFontSizeToFitWidth = true
        usernameLabel.minimumScaleFactor = 0.9
        usernameLabel.lineBreakMode = .byTruncatingTail
        
        usernameLabel.text = user.name
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func configureAddFriendButton() {
        view.addSubview(addFriendButton)
        addFriendButton.translatesAutoresizingMaskIntoConstraints = false
        
        addFriendButton.configuration = UIButton.Configuration.tinted()
        addFriendButton.addTarget(self, action: #selector(addToFriends), for: .touchUpInside)
        addFriendButton.setTitle("Add", for: .normal)
        addFriendButton.setImage(.init(systemName: "plus"), for: .normal)
        addFriendButton.configuration?.imagePadding = 5
        
        NSLayoutConstraint.activate([
            addFriendButton.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor),
            addFriendButton.heightAnchor.constraint(equalToConstant: 44),
            addFriendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addFriendButton.widthAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    @objc private func addToFriends() {
        // TODO: Implement function
    }
}

#Preview {
    FriendProfileViewController(user: MTUser(name: "John", email: "john@icloud.com"))
}
