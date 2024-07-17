//
//  WelcomeViewController.swift
//  MultiTask Tracker
//
//  Created by Zhansen Zhalel on 03.07.2024.
//

import UIKit

class WelcomeViewController: UIViewController {
    let welcomeMessageLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureWelcomeMessageLabel()
    }
    
    func configureWelcomeMessageLabel() {
        view.addSubview(welcomeMessageLabel)
        welcomeMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeMessageLabel.text = "🎉Welcome to Multitask Tracker"
        welcomeMessageLabel.textAlignment = .center
        welcomeMessageLabel.font = UIFont.preferredFont(forTextStyle: .body)
        welcomeMessageLabel.adjustsFontForContentSizeCategory = true
        welcomeMessageLabel.numberOfLines = 2
        
        
        NSLayoutConstraint.activate([
            welcomeMessageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 39),
            welcomeMessageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            welcomeMessageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            welcomeMessageLabel.heightAnchor.constraint(equalToConstant: 33)
        ])
    }
}

#Preview {
    WelcomeViewController().view
}
