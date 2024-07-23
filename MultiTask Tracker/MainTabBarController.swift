//
//  MainTabBarController.swift
//  MultiTask Tracker
//
//  Created by Алексей Волков on 10.07.2024.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabs()
        
        let appearance = UITabBarAppearance()
        
        appearance.configureWithOpaqueBackground()

        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
    
    private func createNavigaiontController(image: UIImage?, viewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: viewController)

        nav.tabBarItem.image = image
        
        return nav
    }
    
    private func setupTabs() {
        let toDo = self.createNavigaiontController(image: UIImage(named: "toDoPic"), viewController: ToDoWelcomeScreen())
        let pomodoro = self.createNavigaiontController(image: UIImage(named: "pomodoroPic"), viewController: PomodoroViewController())
        let friends = self.createNavigaiontController(image: UIImage(named: "friendsPic"), viewController: FriendsViewController())
        let profile = self.createNavigaiontController(image: UIImage(named: "profilePic"), viewController: ProfileViewController())
        
        self.setViewControllers([toDo, pomodoro, friends, profile], animated: true)
    }
    
}


