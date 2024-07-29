//
//  MTTextField.swift
//  MultiTask Tracker
//
//  Created by Zhansen Zhalel on 27.07.2024.
//

import UIKit

class MTTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(placeholderText: String) {
        super.init(frame: .zero)
        configure()
        placeholder = placeholderText
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 25
        layer.borderWidth = 3
        // FIXME: Border color doesn't change with theme
        layer.borderColor = UIColor.label.resolvedColor(with: self.traitCollection).cgColor
        
        autocapitalizationType = .none
        textColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title3)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        autocorrectionType = .no
        returnKeyType = .done
    }
}
