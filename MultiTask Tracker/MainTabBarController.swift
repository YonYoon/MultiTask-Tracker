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
    
    // MARK: - Tab Setup
    private func setupTabs(){
        let home = self.createNav(with: "Home", and: UIImage(named: "homePic"), vc: HomeViewController())
        let statistic = self.createNav(with: "Statistic", and: UIImage(named: "statisticPic"), vc: StatisticViewController())
        let toDo = self.createNav(with: "ToDo", and: UIImage(named: "toDoPic"), vc: ToDoViewController())
        let friends = self.createNav(with: "Friends", and: UIImage(named: "friendsPic"), vc: FriendsViewController())
        let account = self.createNav(with: "Account", and: UIImage(named: "accountPic"), vc: AccountViewController())
        
        self.setViewControllers([home,statistic,toDo,friends,account], animated: true)
    }
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        return nav
    }
}


