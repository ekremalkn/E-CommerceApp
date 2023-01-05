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
    
    private func homeController() -> UIViewController {
        let homeVC = HomeController()
        homeVC.title = "Home"
        homeVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        return homeVC
    }
    
    private func searchController() -> UIViewController {
        let searchVC = SearchController()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
        return searchVC
    }
    
    private func cartController() -> UIViewController {
        let cartVC = CartController()
        cartVC.title = "Cart"
        cartVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "cart"), selectedImage: UIImage(systemName: "cart.fill" ))
        
        return cartVC
    }
    
    private func profileController() -> UIViewController {
        let profileVC = ProfileController()
        profileVC.title = "Profile"
        profileVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person" ), selectedImage: UIImage(systemName: "person.fill"))
        
        return profileVC
    }

}
