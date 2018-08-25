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
		let profileController = ProfileController(collectionViewLayout: UICollectionViewFlowLayout())
		let profileNavController = UINavigationController(rootViewController: profileController)
		profileNavController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
		profileNavController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
		
		self.viewControllers = [profileNavController]
	}
}









