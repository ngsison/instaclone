//
//  MainTabBarController.swift
//  instaclone
//
//  Created by Nathaniel Brion Sison on 21/08/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainTabBarController: UITabBarController {
	
	
	
	// MARK: - Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor.white
		self.tabBar.tintColor = .black
		
		if Auth.auth().currentUser == nil {
			showLoginController()
		} else {
			showMainTabs()
		}
	}
	
	
	
	// MARK: - Functions
	func showLoginController() {
		DispatchQueue.main.async {
			let loginController = LoginController()
			let loginNavController = UINavigationController(rootViewController: loginController)
			self.present(loginNavController, animated: false, completion: nil)
		}
	}
	
	func showMainTabs() {
		let homeTab = createTab(for: HomeController(collectionViewLayout: UICollectionViewFlowLayout()), unselectedIcon: #imageLiteral(resourceName: "home_unselected"), selectedIcon: #imageLiteral(resourceName: "home_selected"))
		let searchTab = createTab(for: SearchController(collectionViewLayout: UICollectionViewFlowLayout()), unselectedIcon: #imageLiteral(resourceName: "search_unselected"), selectedIcon: #imageLiteral(resourceName: "search_selected"))
		let uploadTab = createTab(for: UIViewController(), unselectedIcon: #imageLiteral(resourceName: "plus_unselected"), selectedIcon: #imageLiteral(resourceName: "plus_unselected"))
		let notificationsTab = createTab(for: UIViewController(), unselectedIcon: #imageLiteral(resourceName: "like_unselected"), selectedIcon: #imageLiteral(resourceName: "like_selected"))
		let profileTab = createTab(for: ProfileController(collectionViewLayout: UICollectionViewFlowLayout()), unselectedIcon: #imageLiteral(resourceName: "profile_unselected"), selectedIcon: #imageLiteral(resourceName: "profile_selected"))
		
		self.viewControllers = [homeTab, searchTab, uploadTab, notificationsTab, profileTab]
		self.delegate = self
		
		guard let tabs = self.tabBar.items else { return }
		for tab in tabs {
			tab.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
		}
	}
	
	func createTab(for viewController: UIViewController, unselectedIcon: UIImage, selectedIcon: UIImage) -> UINavigationController {
		let navController =  UINavigationController(rootViewController: viewController)
		navController.tabBarItem.image = unselectedIcon
		navController.tabBarItem.selectedImage = selectedIcon
		return navController
	}
}




// MARK: - Extension: UITabBarControllerDelegate
extension MainTabBarController: UITabBarControllerDelegate {
	func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
		let selectedTabIndex = self.viewControllers?.index(of: viewController)
		
		if selectedTabIndex == 2 {
			let photoSelectorController = PhotoSelectorController(collectionViewLayout: UICollectionViewFlowLayout())
			let photoSelectorNavController = UINavigationController(rootViewController: photoSelectorController)
			present(photoSelectorNavController, animated: true, completion: nil)
			return false
		}
		
		return true
	}
}







