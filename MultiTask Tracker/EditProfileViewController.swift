//
//  EditProfileViewController.swift
//  MultiTask Tracker
//
//  Created by cloud on 24.07.2024.
//

import UIKit

class EditProfileViewController: UIViewController, UITextFieldDelegate {
    
    let setPhotoLabel = UILabel()
    let nameTextField =  UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    let avatarView = UIImageView(image: UIImage(named: "avatar"))
    var dataSource = ["dsfsdfdsf", "zxlckhj"]
    
    
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAvatarView()
        configureNameTextField()
        configureSetPhotoLabel()
        
        
        
        func configureAvatarView() {
            view.addSubview(avatarView)
            avatarView.translatesAutoresizingMaskIntoConstraints = false
            
            let avatarSize: CGFloat = 100
            
            NSLayoutConstraint.activate([
                avatarView.topAnchor.constraint(equalTo:
                                                    view.safeAreaLayoutGuide.topAnchor, constant: 25),
                avatarView.heightAnchor.constraint(equalToConstant: avatarSize),
                avatarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                avatarView.widthAnchor.constraint(equalToConstant: avatarSize)
            ])
        }
        
        func configureSetPhotoLabel(){
            view.addSubview(setPhotoLabel)
            
            setPhotoLabel.text = "Set New Photo"
            setPhotoLabel.font = UIFont.preferredFont(forTextStyle: .body)
            setPhotoLabel.adjustsFontForContentSizeCategory = true
            
            setPhotoLabel.translatesAutoresizingMaskIntoConstraints = false
            
            setPhotoLabel.textAlignment = .center
            
            NSLayoutConstraint.activate([
                
                setPhotoLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor),
                setPhotoLabel.bottomAnchor.constraint(equalTo: nameTextField.topAnchor),
                setPhotoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                setPhotoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        }
        
        
        
        func configureNameTextField() {
            
            nameTextField.placeholder = "Enter your nickname here"
            
            nameTextField.borderStyle = UITextField.BorderStyle.roundedRect
            nameTextField.autocorrectionType = UITextAutocorrectionType.no
            nameTextField.keyboardType = UIKeyboardType.default
            nameTextField.returnKeyType = UIReturnKeyType.done
            nameTextField.clearButtonMode = UITextField.ViewMode.whileEditing
            nameTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
            nameTextField.delegate = self
            nameTextField.backgroundColor = .accent
            
            view.addSubview(nameTextField)
            
            let TextFieldSize: CGFloat = 100
            
            nameTextField.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                nameTextField.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 80),
                nameTextField.heightAnchor.constraint(equalToConstant: TextFieldSize/2),
                nameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
                nameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40)
            ])
            
            
        }
        
    }
}
