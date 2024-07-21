//
//  CalendarViewController.swift
//  MultiTask Tracker
//
//  Created by Алексей Волков on 21.07.2024.
//

import UIKit

class CalendarViewController: UIViewController {
    var notificationsButton = UIButton()
    var storiesView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "background")
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        textLabel()
    }
    
    // Тут есть проблема констреинтов для SE (выглядит не по центру). Этим займемся позже
    private func setTextList(text: String, сolor: UIColor, constraintTop: Double, constraintLeading: Double){
        let label = UILabel()
        label.text = text
        label.textColor = сolor
        label.font = UIFont.systemFont(ofSize: 30)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate ([
        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: constraintTop),
        label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: constraintLeading),
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func textLabel (){
        setTextList(text: "Choose", сolor: .white, constraintTop: 20, constraintLeading: 31)
        setTextList(text: "your", сolor: .white, constraintTop: 20, constraintLeading: 138)
        setTextList(text: "mood", сolor: UIColor(named: "AccentColor")!, constraintTop: 20, constraintLeading: 202)
        setTextList(text: "today", сolor: .white, constraintTop: 20, constraintLeading: 284)
    }
    
    private func CalendarView(){
        
        
        
    }
    
    
    
    
}
