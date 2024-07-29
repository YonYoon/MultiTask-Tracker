//
//  LoginViewController.swift
//  MultiTask Tracker
//
//  Created by Zhansen Zhalel on 03.07.2024.
//

import UIKit

class LoginViewController: UIViewController {
    let welcomeMessageLabel = UILabel()
    let mascotImageView = UIImageView(image: UIImage(named: "welcomeImage"))
    let emailField = MTTextField(placeholderText: "Enter your email")
    let passwordField = MTTextField(placeholderText: "Enter your password")
    let loginButton = MTButton(title: "Login")
    let stackView = UIStackView()
    let signUpLabel = UILabel()
    let showSignUpButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "background")
        
        configureWelcomeMessageLabel()
        configureMascotImage()
        configureEmailField()
        configurePasswordField()
        configureLoginButton()
        configureSignUpLabel()
        configureSignUpButton()
        configureStackView()
        layoutSignUp()
    }
    
    func configureWelcomeMessageLabel() {
        view.addSubview(welcomeMessageLabel)
        welcomeMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeMessageLabel.text = "Welcome to MultiTask Tracker"
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
    
    func configureMascotImage() {
        view.addSubview(mascotImageView)
        mascotImageView.translatesAutoresizingMaskIntoConstraints = false
        mascotImageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            mascotImageView.topAnchor.constraint(equalTo: welcomeMessageLabel.bottomAnchor, constant: 39),
            mascotImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 69),
            mascotImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -59.85),
            mascotImageView.heightAnchor.constraint(equalToConstant: 254.34)
        ])
    }
    
    // FIXME: Text field is hidden under the keyboard
    func configureEmailField() {
        view.addSubview(emailField)
                
        NSLayoutConstraint.activate([
            emailField.topAnchor.constraint(equalTo: mascotImageView.bottomAnchor, constant: 48),
            emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 42),
            emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -42),
            emailField.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    func configurePasswordField() {
        view.addSubview(passwordField)
        passwordField.isSecureTextEntry = true
        
        NSLayoutConstraint.activate([
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 15),
            passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 42),
            passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -42),
            passwordField.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    func configureLoginButton() {
        view.addSubview(loginButton)
        
        loginButton.addTarget(self, action: #selector(authenticate), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 69),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -69),
            loginButton.heightAnchor.constraint(equalToConstant: 46),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100)
        ])
    }
    
    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(signUpLabel)
        stackView.addArrangedSubview(showSignUpButton)
    }
    
    private func configureSignUpLabel() {
        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
        
        signUpLabel.text = "Don't have an account?"
        // FIXME: Add support for dynamic type
        signUpLabel.font = UIFont.preferredFont(forTextStyle: .callout)
        signUpLabel.adjustsFontForContentSizeCategory = true
    }
    
    private func configureSignUpButton() {
        showSignUpButton.translatesAutoresizingMaskIntoConstraints = false
        showSignUpButton.setTitle("Sign up", for: .normal)
        
        showSignUpButton.addTarget(self, action: #selector(switchToSignUp), for: .touchUpInside)
    }
    
    private func layoutSignUp() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 20)
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
    
    @objc private func switchToSignUp() {
        AuthenticationManager.shared.flow = .signUp
        
        let signUpViewController = SignUpViewController()
        signUpViewController.modalPresentationStyle = .fullScreen
        signUpViewController.modalTransitionStyle = .crossDissolve
        self.present(signUpViewController, animated: true)
    }
}

#Preview {
    LoginViewController()
}
