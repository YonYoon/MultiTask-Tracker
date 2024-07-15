//
//  FriendsStoriesViewController.swift
//  MultiTask Tracker
//
//  Created by Zhansen Zhalel on 15.07.2024.
//

import UIKit

class FriendsStoriesViewController: UIViewController {
    let stackView = UIStackView()
    let story1 = StoriesView()
    let story2 = StoriesView()
    let story3 = StoriesView()
    let story4 = StoriesView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        stackView.addArrangedSubview(story1)
        stackView.addArrangedSubview(story2)
        stackView.addArrangedSubview(story3)
        stackView.addArrangedSubview(story4)
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 73)
        ])
    }
}
