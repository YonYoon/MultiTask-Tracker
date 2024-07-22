//
//  WelcomeViewController.swift
//  MultiTask Tracker
//
//  Created by Zhansen Zhalel on 03.07.2024.
//

import UIKit

class WelcomeViewController: UIViewController {
    let welcomeMessageLabel = UILabel()
    let welcomeImageView = UIImageView(image: UIImage(named: "welcomeImage"))
    let nameField = UITextField()
    let saveButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "background")
        
        configureWelcomeMessageLabel()
        configureWelcomeImage()
        configureNameField()
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
        view.addSubview(nameField)
        nameField.translatesAutoresizingMaskIntoConstraints = false
        
        nameField.layer.cornerRadius = 25
        nameField.layer.borderWidth = 3
        // FIXME: - Border color doesn't change with theme
        nameField.layer.borderColor = UIColor.label.resolvedColor(with: self.traitCollection).cgColor
        
        nameField.textColor = .label
        nameField.textAlignment = .center
        nameField.font = UIFont.preferredFont(forTextStyle: .title3)
        nameField.adjustsFontSizeToFitWidth = true
        nameField.minimumFontSize = 12
        
        nameField.autocorrectionType = .no
        nameField.returnKeyType = .done
        nameField.placeholder = "Enter your name"
        
        NSLayoutConstraint.activate([
            nameField.topAnchor.constraint(equalTo: welcomeImageView.bottomAnchor, constant: 48),
            nameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 42),
            nameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -42),
            nameField.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    func configureSaveButton() {
        view.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        saveButton.backgroundColor = .accent
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        saveButton.layer.cornerRadius = 25
        saveButton.setTitleColor(.white, for: .normal)
        
        NSLayoutConstraint.activate([
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 69),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -69),
            saveButton.heightAnchor.constraint(equalToConstant: 46),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }
}

#Preview {
    let viewController = WelcomeViewController()
    return viewController.view
}
