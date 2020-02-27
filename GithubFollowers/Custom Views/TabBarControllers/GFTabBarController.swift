//
//  GFTabBarController.swift
//  GithubFollowers
//
//  Created by Stefan Romanescu on 27/02/2020.
//  Copyright © 2020 StefanCosmin. All rights reserved.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UITabBar.appearance().tintColor = .systemGreen
        self.viewControllers = [
            createSearchNavigationController(),
            createFavoritesNavigationController()
        ]
    }
    
    func createSearchNavigationController() -> UINavigationController {
           let searchVC = SearchVC()
           searchVC.title = "Search"
           searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
           
           return UINavigationController(rootViewController: searchVC)
       }
       
       func createFavoritesNavigationController() -> UINavigationController {
           let favoritesVC = FavoritesListVC()
           favoritesVC.title = "Favorites"
           favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
           
           return UINavigationController(rootViewController: favoritesVC)
       }
       
}
