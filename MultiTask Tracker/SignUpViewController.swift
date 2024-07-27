//
//  SignUpViewController.swift
//  MultiTask Tracker
//
//  Created by Zhansen Zhalel on 27.07.2024.
//

import UIKit

class SignUpViewController: UIViewController {
    var nameField = UITextField()
    var emailField = UITextField()
    var passwordField = UITextField()
    var confirmPasswordField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        navigationItem.title = "Sign-up"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureNameField()
        configureEmailField()
        configurePasswordField()
        configureConfirmPasswordField()
    }
    
    private func configureNameField() {
        setup(textField: nameField, placeholderText: "Name")
        
        nameField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
    }
    
    private func configureEmailField() {
        setup(textField: emailField, placeholderText: "Email")
        
        emailField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 15).isActive = true
    }
    
    private func configurePasswordField() {
        setup(textField: passwordField, placeholderText: "Password")
        
        passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 15).isActive = true
    }
    
    private func configureConfirmPasswordField() {
        setup(textField: confirmPasswordField, placeholderText: "Confirm password")
        
        confirmPasswordField.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 15).isActive = true
    }
    
    private func setup(textField: UITextField, placeholderText: String) {
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.borderStyle = .roundedRect
        textField.placeholder = placeholderText
        
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 50),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
    }
}

#Preview {
    let navigationController = UINavigationController(rootViewController: SignUpViewController())
    return navigationController.view
}
