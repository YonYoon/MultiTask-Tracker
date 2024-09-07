//
//  MTImageView.swift
//  MultiTask Tracker
//
//  Created by Zhansen Zhalel on 30.08.2024.
//

import UIKit

class MTImageView: UIImageView {
    let placeholderImage = UIImage(systemName: "person.crop.square.fill")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
}
