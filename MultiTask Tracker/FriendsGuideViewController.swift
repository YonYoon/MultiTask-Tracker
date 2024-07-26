//
//  FriendsGuideViewController.swift
//  MultiTask Tracker
//
//  Created by Zhansen Zhalel on 24.07.2024.
//

import UIKit

class FriendsGuideViewController: UIViewController {
    let descriptionLabel = UILabel()
    let goButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        configureDescriptionLabel()
        configureGoButton()
    }
    
    // TODO: - Add attributed strings
    // TODO: - Change font weight, preserve dynamic type
    private func configureDescriptionLabel() {
        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.attributedText = NSAttributedString(string: "Add new friends\nShare your achievements\nHave fun")
        
        descriptionLabel.numberOfLines = 3
        descriptionLabel.textAlignment = .natural
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        descriptionLabel.adjustsFontSizeToFitWidth = true
        
        NSLayoutConstraint.activate([
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 215),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 100),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 345)
        ])
    }
    
    // TODO: - Add target
    private func configureGoButton() {
        view.addSubview(goButton)
        goButton.translatesAutoresizingMaskIntoConstraints = false
        
        goButton.setTitle("Let's go!", for: .normal)
        goButton.backgroundColor = UIColor.accent
        goButton.layer.cornerRadius = 10
        goButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        
        NSLayoutConstraint.activate([
            goButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            goButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goButton.heightAnchor.constraint(equalToConstant: 50),
            goButton.widthAnchor.constraint(equalToConstant: 210)
        ])
    }
}
