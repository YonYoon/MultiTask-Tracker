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
    
    private func createNavigaiontController(title: String, image: UIImage?, viewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: viewController)
        
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        return nav
    }
    
    private func setupTabs() {
        let toDo = self.createNavigaiontController(title: "ToDo", image: UIImage(named: "toDoPic"), viewController: ReminderListViewController())
        let pomodoro = createNavigaiontController(title: "Pomodoro", image: UIImage(systemName: "timer"), viewController: PomodoroViewController())
        let friends = self.createNavigaiontController(title: "Friends", image: UIImage(named: "friendsPic"), viewController: FriendsViewController())
        let account = self.createNavigaiontController(title: "Profile", image: UIImage(named: "accountPic"), viewController: ProfileViewController())
        
        self.setViewControllers([toDo, pomodoro, friends, account], animated: true)
    }
    
}


