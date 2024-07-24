//
//  ToDoViewController.swift
//  MultiTask Tracker
//
//  Created by Алексей Волков on 10.07.2024.
//

import UIKit

class ToDoViewController: UIViewController {
    
    private let registerTextField = RegisterTextField(placeholder: "What would you like to do?")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor (named: "background")
        setupView()
    }
    
    // Для того, чтобы при нажатии клавиатура пропадала
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

//MARK: - Setting Views
    private extension ToDoViewController{
        func setupView(){
            addSubViews()
            setupLayout()
        }
    }

//MARK: - Setting
    private extension ToDoViewController{
        func addSubViews(){
            view.addSubview(registerTextField)
        }
    }
    
//MARK: - Layout
    private extension ToDoViewController{
        func setupLayout(){
            registerTextField.translatesAutoresizingMaskIntoConstraints = false
            registerTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            //registerTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true     Пока под вопросом
            registerTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            registerTextField.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        }
    }
