//
//  HomeViewController.swift
//  MultiTask Tracker
//
//  Created by Алексей Волков on 10.07.2024.
//

import UIKit

class HomeViewController: UIViewController {
    var notificationsButton = UIButton()
    var storiesView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "background")
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        configureNotificationsButton()
        configureStoriesView()
    }
    
    // TODO: - Add target
    private func configureNotificationsButton() {
        let size: CGFloat = 25
        
        view.addSubview(notificationsButton)
        notificationsButton.translatesAutoresizingMaskIntoConstraints = false
        
        notificationsButton.setBackgroundImage(UIImage(named: "bell"), for: .normal)
        
        NSLayoutConstraint.activate([
            notificationsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            notificationsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            notificationsButton.heightAnchor.constraint(equalToConstant: size),
            notificationsButton.widthAnchor.constraint(equalToConstant: size)
        ])
    }
    
    private func configureStoriesView() {
        let padding: CGFloat = 20
        
        view.addSubview(storiesView)
        storiesView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            storiesView.topAnchor.constraint(equalTo: notificationsButton.bottomAnchor, constant: 15),
            storiesView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            storiesView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            storiesView.heightAnchor.constraint(equalToConstant: 73)
        ])
        
        let friendsStoriesViewController = FriendsStoriesViewController()
        addChild(friendsStoriesViewController)
        storiesView.addSubview(friendsStoriesViewController.view)
        friendsStoriesViewController.view.frame = storiesView.bounds
        friendsStoriesViewController.didMove(toParent: self)
    }
    
    private lazy var textStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private func setStories() {
        let circle1 = createCircle(frame: CGRect(x: view.frame.width-362, y: 100, width: 65, height: 65))
        let circle2 = createCircle(frame: CGRect(x: view.frame.width-272, y: 100, width: 65, height: 65))
        let circle3 = createCircle(frame: CGRect(x: view.frame.width-182, y: 100, width: 65, height: 65))
        let circle4 = createCircle(frame: CGRect(x: view.frame.width-92, y: 100, width: 65, height: 65))
        
        [circle1,circle2,circle3,circle4].forEach {item in
            view.addSubview(item)
        }
    }
    
    private func setGlow() {
        view.addSubview(glow)
        glow.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -30).isActive = true
        glow.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,constant: -200).isActive = true
    }
    
    private func setStoriesBord() {
        let sBord1 = createCircleBord(frame: CGRect(x: view.frame.width-366, y: 96, width: 73, height: 73))
        let sBord2 = createCircleBord(frame: CGRect(x: view.frame.width-276, y: 96, width: 73, height: 73))
        let sBord3 = createCircleBord(frame: CGRect(x: view.frame.width-186, y: 96, width: 73, height: 73))
        let sBord4 = createCircleBord(frame: CGRect(x: view.frame.width-96, y: 96, width: 73, height: 73))
        
        [sBord1,sBord2,sBord3,sBord4].forEach {item in
            view.addSubview(item)
        }
    }
    
//    private func setBell() {
//        view.addSubview(bell)
//        bell.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -35).isActive = true
//        bell.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,constant: -40).isActive = true
//    }
    
    private func setSquare() {
        let square1 = createRectangle(frame: CGRect(x: view.frame.width-380, y: 188, width: 370, height: 97))
        let square2 = createRectangle(frame: CGRect(x: view.frame.width-380, y: 300, width: 370, height: 440))
        
        view.addSubview(square1)
        view.addSubview(square2)
    }
    
    //    Кнопка
    // К этому моменту сложно подобрать цензурные слова
    private func setButton(btnColor: String, btnTextColor: UIColor, btnText: String, btnLBorder: Double, btnRBorder: Double, btnBotLength: Double){
        
        //let pic = UIImage(named: "plansPic")
        lazy var button: UIButton = {
            let btn = UIButton(primaryAction: buttonAction)
            /* if let pic = pic {
             btn.setImage(pic, for: .normal)
             
             // Устанавливаем контент-режим
             btn.imageView?.contentMode = .scaleAspectFit
             // Изменяем размер frame для imageView
             btn.imageView?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
             
             // Отступы для изображения
             btn.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 15)
             btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
             } */
            
            btn.setTitle(btnText, for: .normal)
            btn.setTitleColor(btnTextColor, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            btn.layer.cornerRadius = 15
            btn.backgroundColor = UIColor(named: btnColor)
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.heightAnchor.constraint(equalToConstant: 60).isActive = true
            
            return btn
        }()
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: btnLBorder),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: btnRBorder),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: btnBotLength),
        ])
        
    }
    
    private lazy var buttonAction = UIAction { _ in
        print(1)
    }
    
    private func setTextList(){
        view.addSubview(textStack)
        
        let pageTitle = createLabel(size: 20, weight: .bold, text: "My lists")
        textStack.addArrangedSubview(pageTitle)
        
        NSLayoutConstraint.activate ([
            textStack.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 45),
            textStack.bottomAnchor.constraint(equalTo: view.topAnchor,constant: 342)
        ])
    }
    
    private func createCircle(frame: CGRect) -> UIView {
        let circle = UIView()
        circle.backgroundColor = UIColor(named: "border")
        circle.frame = frame
        circle.layer.cornerRadius = 33
        return circle
    }
    
    private func createCircleBord(frame: CGRect) -> UIView {
        let circle = UIView()
        circle.backgroundColor = UIColor(named: "defaultButtonColor")
        circle.frame = frame
        circle.layer.cornerRadius = 37
        return circle
    }
    
    
    private lazy var glow: UIImageView = {
        let glow = UIImageView()
        glow.image = UIImage(named: "glow")
        glow.contentMode = .scaleToFill
        glow.translatesAutoresizingMaskIntoConstraints = false
        glow.heightAnchor.constraint(equalToConstant: view.frame.height/6).isActive = true
        glow.widthAnchor.constraint(equalToConstant: view.frame.height/3).isActive = true
        return glow
    }()
    
    private func createRectangle(frame: CGRect) -> UIView {
        let square = UIView()
        square.backgroundColor = UIColor(named: "border")
        square.frame = frame
        square.layer.cornerRadius = 30
        return square
    }
    
    private func createLabel(size: CGFloat, weight: UIFont.Weight, text: String) -> UILabel{
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: size,weight: weight)
        return label
    }
}

