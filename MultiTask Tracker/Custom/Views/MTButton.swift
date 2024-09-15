//
//  MTButton.swift
//  MultiTask Tracker
//
//  Created by Zhansen Zhalel on 28.07.2024.
//

import UIKit

class MTButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String) {
        super.init(frame: .zero)
        configure()
        setTitle(title, for: .normal)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .accent
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        layer.cornerRadius = 15
        setTitleColor(.white, for: .normal)
    }
}
