//
//  WelcomeViewController.swift
//  MultiTask Tracker
//
//  Created by Zhansen Zhalel on 03.07.2024.
//

import UIKit
import FirebaseAuth

class WelcomeViewController: UIViewController {
    let welcomeMessageLabel = UILabel()
    let welcomeImageView = UIImageView(image: UIImage(named: "welcomeImage"))
    let emailField = MTTextField(placeholderText: "Enter your email")
    let passwordField = MTTextField(placeholderText: "Enter your password")
    let saveButton = UIButton()
    var user: User? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "background")
        
        configureWelcomeMessageLabel()
        configureWelcomeImage()
        configureEmailField()
        configurePasswordField()
        configureSaveButton()
    }
    
    func configureWelcomeMessageLabel() {
        view.addSubview(welcomeMessageLabel)
        welcomeMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeMessageLabel.text = "🎉Welcome to Multitask Tracker"
        welcomeMessageLabel.textAlignment = .center
        // FIXME: Add support for dynamic type
        welcomeMessageLabel.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        welcomeMessageLabel.adjustsFontForContentSizeCategory = true
        welcomeMessageLabel.numberOfLines = 2
        
        NSLayoutConstraint.activate([
            welcomeMessageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 39),
            welcomeMessageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            welcomeMessageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            welcomeMessageLabel.heightAnchor.constraint(equalToConstant: 33)
        ])
    }
    
    func configureWelcomeImage() {
        view.addSubview(welcomeImageView)
        welcomeImageView.translatesAutoresizingMaskIntoConstraints = false
        welcomeImageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            welcomeImageView.topAnchor.constraint(equalTo: welcomeMessageLabel.bottomAnchor, constant: 39),
            welcomeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 69),
            welcomeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -59.85),
            welcomeImageView.heightAnchor.constraint(equalToConstant: 254.34)
        ])
    }
    
    // FIXME: Text field is hidden under the keyboard
    func configureEmailField() {
        view.addSubview(emailField)
                
        NSLayoutConstraint.activate([
            emailField.topAnchor.constraint(equalTo: welcomeImageView.bottomAnchor, constant: 48),
            emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 42),
            emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -42),
            emailField.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    func configurePasswordField() {
        view.addSubview(passwordField)
        
        NSLayoutConstraint.activate([
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 15),
            passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 42),
            passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -42),
            passwordField.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    func configureSaveButton() {
        view.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        saveButton.backgroundColor = .accent
        saveButton.setTitle("Login", for: .normal)
        saveButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        saveButton.layer.cornerRadius = 25
        saveButton.setTitleColor(.white, for: .normal)
        
        saveButton.addTarget(self, action: #selector(authenticate), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 69),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -69),
            saveButton.heightAnchor.constraint(equalToConstant: 46),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }
    
    @objc private func authenticate() {
        guard let email = emailField.text, !email.isEmpty, let password = passwordField.text, !password.isEmpty else {
            print("No email and/or password")
            let alertController = UIAlertController(title: "Error", message: "Please write your email and password to login", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertController, animated: true)
            return
        }
        
        Task {
            let isAuthenticated = await AuthenticationManager.shared.signInWith(email: email, password: password)
            
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
    WelcomeViewController().view
}
