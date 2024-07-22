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
        let home = self.createNavigaiontController(title: "Home", image: UIImage(named: "homePic"), viewController: HomeViewController())
        let statistics = self.createNavigaiontController(title: "Statistics", image: UIImage(named: "statisticPic"), viewController: StatisticViewController())
        let toDo = self.createNavigaiontController(title: "ToDo", image: UIImage(named: "toDoPic"), viewController: ToDoViewController())
        let friends = self.createNavigaiontController(title: "Friends", image: UIImage(named: "friendsPic"), viewController: FriendsViewController())
        let account = self.createNavigaiontController(title: "Account", image: UIImage(named: "accountPic"), viewController: ProfileViewController())
        
        self.setViewControllers([home, statistics, toDo, friends, account], animated: true)
    }
    
}


