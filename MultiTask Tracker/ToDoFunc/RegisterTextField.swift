//
//  RegisterTextField.swift
//  MultiTask Tracker
//
//  Created by Алексей Волков on 23.07.2024.
//

import UIKit

//MARK: - RegisterTextField
// от final class невозможно создать подклассы
final class RegisterTextField: UITextField {
    
    
    
    private let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 40)
    
    //MARK: - Initializers
    init(placeholder: String ){
        super.init(frame: .zero)
        setupTextField(placeholder: placeholder)
        
        self.becomeFirstResponder() // Клавиатура вылетает с багом
    }
    // В случае ошибки
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect{
        bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    private func setupTextField(placeholder: String){
        textColor = .black
        layer.cornerRadius = 20
        layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "textGray")!])
        
        font = .systemFont(ofSize: 18, weight: .regular)
        heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
}
