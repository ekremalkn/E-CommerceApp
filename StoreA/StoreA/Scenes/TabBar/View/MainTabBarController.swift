//
//  MainTabBarController.swift
//  StoreA
//
//  Created by Ekrem Alkan on 5.01.2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        configureTabBar()
        
    }
    
    private func setupTabBar() {
        let viewControllers = [homeController(), searchController(), cartController(), profileController()]
        setViewControllers(viewControllers, animated: true)
    }
    
    private func configureTabBar() {
        tabBar.itemPositioning = .centered
        tabBar.tintColor = .black
    }
    
    private func homeController() -> UINavigationController {
        let homeVC = HomeController()
        homeVC.title = "StoreA"
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        return UINavigationController(rootViewController: homeVC)
    }
    
    private func searchController() -> UINavigationController {
        let searchVC = SearchController()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    private func cartController() -> UINavigationController {
        let cartVC = CartController()
        cartVC.title = "Cart"
        cartVC.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(systemName: "cart"), selectedImage: UIImage(systemName: "cart.fill" ))
        
        return UINavigationController(rootViewController: cartVC)
    }
    
    private func profileController() -> UINavigationController {
        let profileVC = ProfileController()
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person" ), selectedImage: UIImage(systemName: "person.fill"))
        
        return UINavigationController(rootViewController: profileVC)
    }
    
}
