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
    var signUpButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        navigationItem.title = "Sign-up"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        configureNameField()
        configureEmailField()
        configurePasswordField()
        configureConfirmPasswordField()
        configureSignUpButton()
        createDismissKeyboardTapGesture()
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
        passwordField.isSecureTextEntry = true
        
        passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 15).isActive = true
    }
    
    private func configureConfirmPasswordField() {
        setup(textField: confirmPasswordField, placeholderText: "Confirm password")
        confirmPasswordField.isSecureTextEntry = true
        
        confirmPasswordField.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 15).isActive = true
    }
    
    private func setup(textField: UITextField, placeholderText: String) {
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.autocapitalizationType = .none
        textField.borderStyle = .roundedRect
        textField.placeholder = placeholderText
        
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 50),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
    }
    
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    private func configureSignUpButton() {
        view.addSubview(signUpButton)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        
        signUpButton.backgroundColor = .accent
        signUpButton.setTitle("Sign up", for: .normal)
        signUpButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        signUpButton.layer.cornerRadius = 25
        signUpButton.setTitleColor(.white, for: .normal)
        
        signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 69),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -69),
            signUpButton.heightAnchor.constraint(equalToConstant: 46),
            signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }
    
    @objc private func signUp() {
        guard let name = nameField.text, !name.isEmpty else {
            print("No name")
            let alertController = UIAlertController(title: "Error", message: "Please write your name to login", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true)
            return
        }
        
        guard let email = emailField.text, !email.isEmpty, let password = passwordField.text, !password.isEmpty else {
            print("No email and/or password")
            let alertController = UIAlertController(title: "Error", message: "Please write your email and password to login", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true)
            return
        }
        
        guard let confirmationPassword = confirmPasswordField.text, !confirmationPassword.isEmpty else {
            print("No confirmation password")
            let alertController = UIAlertController(title: "Error", message: "Please write your confirmation password to login", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true)
            return
        }
        
        if password != confirmationPassword {
            print("Passwords do not match")
            let alertController = UIAlertController(title: "Error", message: "Passwords do not match", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true)
            return
        }
        
        Task {
            let isAuthenticated = await AuthenticationManager.shared.signUpWith(email: email, password: password)
            
            if isAuthenticated {
                let mainTabBarController = MainTabBarController()
                mainTabBarController.modalPresentationStyle = .fullScreen
                self.present(mainTabBarController, animated: true)
            } else {
                let alertController = UIAlertController(title: "Error", message: "Your info is invalid or you don't have an account", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alertController, animated: true)
            }
        }
    }
}

#Preview {
    UINavigationController(rootViewController: SignUpViewController())
}
