//
//  StoriesView.swift
//  MultiTask Tracker
//
//  Created by Zhansen Zhalel on 15.07.2024.
//

import UIKit

class StoriesView: UIView {
    let avatarImageView = UIImageView(image: UIImage(systemName: "person.crop.circle.fill"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(avatarImageView)
        
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.tintColor = .lightGray
        avatarImageView.layer.borderWidth = 4
        avatarImageView.layer.borderColor = UIColor.tintColor.cgColor
        avatarImageView.layer.cornerRadius = 36.5
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: self.topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 73),
            avatarImageView.heightAnchor.constraint(equalToConstant: 73)
        ])
    }
}
