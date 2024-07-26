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
    let emailField = UITextField()
    let passwordField = UITextField()
    let saveButton = UIButton()
    var user: User? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "background")
        
        configureWelcomeMessageLabel()
        configureWelcomeImage()
        configureNameField()
        configurePasswordField()
        configureSaveButton()
    }
    
    func configureWelcomeMessageLabel() {
        view.addSubview(welcomeMessageLabel)
        welcomeMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeMessageLabel.text = "🎉Welcome to Multitask Tracker"
        welcomeMessageLabel.textAlignment = .center
        // FIXME: - Label doesn't support dynamic type
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
    
    // FIXME: - Text field is hidden under the keyboard
    func configureNameField() {
        view.addSubview(emailField)
        emailField.translatesAutoresizingMaskIntoConstraints = false
        
        emailField.layer.cornerRadius = 25
        emailField.layer.borderWidth = 3
        // FIXME: - Border color doesn't change with theme
        emailField.layer.borderColor = UIColor.label.resolvedColor(with: self.traitCollection).cgColor
        
        emailField.autocapitalizationType = .none
        emailField.textColor = .label
        emailField.textAlignment = .center
        emailField.font = UIFont.preferredFont(forTextStyle: .title3)
        emailField.adjustsFontSizeToFitWidth = true
        emailField.minimumFontSize = 12
        
        emailField.autocorrectionType = .no
        emailField.returnKeyType = .done
        emailField.placeholder = "Enter your email"
        
        NSLayoutConstraint.activate([
            emailField.topAnchor.constraint(equalTo: welcomeImageView.bottomAnchor, constant: 48),
            emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 42),
            emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -42),
            emailField.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    func configurePasswordField() {
        view.addSubview(passwordField)
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        
        passwordField.layer.cornerRadius = 25
        passwordField.layer.borderWidth = 3
        // FIXME: - Border color doesn't change with theme
        passwordField.layer.borderColor = UIColor.label.resolvedColor(with: self.traitCollection).cgColor
        
        passwordField.autocapitalizationType = .none
        passwordField.textColor = .label
        passwordField.textAlignment = .center
        passwordField.font = UIFont.preferredFont(forTextStyle: .title3)
        passwordField.adjustsFontSizeToFitWidth = true
        passwordField.minimumFontSize = 12
        
        passwordField.autocorrectionType = .no
        passwordField.returnKeyType = .done
        passwordField.placeholder = "Enter your password"
        
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
        Auth.auth().signIn(withEmail: emailField.text ?? "", password: passwordField.text ?? "") { [weak self] authResult, error in
            guard let self else { return }
            
            if let error = error {
                print("Failed to sign in: \(error.localizedDescription)")
                return
            }
            
            if let authResult = authResult {
                print("User signed in: \(authResult.user.email ?? "No Email")")
                user = authResult.user
            }
        }
    }
}

#Preview {
    WelcomeViewController().view
}
