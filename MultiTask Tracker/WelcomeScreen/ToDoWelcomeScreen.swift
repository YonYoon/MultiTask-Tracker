//
//  ToDoWelcomeScreen.swift
//  MultiTask Tracker
//
//  Created by Алексей Волков on 22.07.2024.
//

import UIKit

class ToDoWelcomeScreen: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor (named: "background")
        
        createText1Label(text: "CREATE",size: 50)
        createText2Label(text: "your first list",size: 40)
        setButton()
    }
    
    private func createText1Label(text: String, size: Double) {
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: text.count))
        
        let label = UILabel()
        label.attributedText = attributedText
        label.font = UIFont.systemFont(ofSize: size, weight: .bold)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .label
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func createText2Label(text: String, size: Double) {
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.foregroundColor, value: UIColor.label, range: NSRange(location: 0, length: 4))
        attributedText.addAttribute(.foregroundColor, value: UIColor(named: "AccentColor")!, range: NSRange(location: 5, length: 5))
        attributedText.addAttribute(.foregroundColor, value: UIColor.label, range: NSRange(location: 11, length: 4))
        
    
        let label = UILabel()
        label.attributedText = attributedText
        label.font = UIFont.systemFont(ofSize: size)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setButton(){
        let button = UIButton()
        button.setTitle("Lets Go!", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        button.backgroundColor = UIColor(named: "defaultButtonColor")
        button.layer.cornerRadius = 30
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 92),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -92),
            button.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
    
    // При нажатии открывает основную страницу ToDo
        @objc func buttonTapped() {
                let nextViewController = ToDoViewController()

                navigationController?.pushViewController(nextViewController, animated: true)
            }
}
