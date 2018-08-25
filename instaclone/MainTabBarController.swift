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
		
		if Auth.auth().currentUser == nil {
			DispatchQueue.main.async {
				let loginController = LoginController()
				self.present(loginController, animated: true, completion: nil)
			}
			return
		}
		
		let profileController = ProfileController(collectionViewLayout: UICollectionViewFlowLayout())
		let profileNavController = UINavigationController(rootViewController: profileController)
		profileNavController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
		profileNavController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
		
		self.tabBar.tintColor = .black
		self.viewControllers = [profileNavController]
	}
	
}
