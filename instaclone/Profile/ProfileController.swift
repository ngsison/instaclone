//
//  ProfileController.swift
//  instaclone
//
//  Created by Nathaniel Brion Sison on 21/08/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ProfileController: UICollectionViewController {
	
	
	
	// MARK: - Properties
	private var user: User? {
		didSet {
			self.navigationItem.title = user?.username
		}
	}
	
	
	
	// MARK: - Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
		configureCollectionView()
		setupViews()
		fetchUser()
		fetchPosts()
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.user?.posts.count ?? 0
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCell.identifier, for: indexPath) as! ProfileCell
		cell.post = self.user?.posts[indexPath.item]
		return cell
	}
	
	override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		
		let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileHeader.identifier, for: indexPath) as! ProfileHeader
		
		if let user = self.user {
			header.user = user
		}
		
		return header
	}
	
	

	// MARK: - Events
	@objc private func onLogoutButtonPress() {
		let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
		
		let logoutAction = UIAlertAction(title: "Log Out", style: .destructive) { (_) in
			self.logOut()
		}
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		
		alertController.addAction(logoutAction)
		alertController.addAction(cancelAction)
		
		present(alertController, animated: true, completion: nil)
	}
	
	
	
	// MARK: - Functions
	private func configureCollectionView() {
		collectionView?.collectionViewLayout = UICollectionViewFlowLayout()
		collectionView?.register(ProfileCell.self, forCellWithReuseIdentifier: ProfileCell.identifier)
		collectionView?.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ProfileHeader.identifier)
	}

	private func fetchUser() {
		guard let userID = Auth.auth().currentUser?.uid else { return }
		
		let reference = Database.database().reference().child("users")
		reference.child(userID).observeSingleEvent(of: DataEventType.value) { (snapshot: DataSnapshot) in
			guard let snapshotDict = snapshot.value as? [String: Any] else { return }
			self.user = User(withDictionary: snapshotDict)
			self.collectionView?.reloadData()
		}
	}
	
	private func logOut() {
		do {
			try Auth.auth().signOut()
			print("Successfully logged out")
			
			/**
				Presenting new instance of LoginController because:
					- it's going to be dismissed anyway.
					- the 'showLoginController' of rootViewController is not animated.
			
				After dismissal of the LoginController/SignupController:
					- rootViewController's (MainTabBarController) viewControllers will be reset by calling 'showMainTabs'
			*/
			
			let loginController = LoginController()
			let loginNavController = UINavigationController(rootViewController: loginController)
			present(loginNavController, animated: true, completion: nil)
		} catch let error {
			print("Error signing out: \(error)")
		}
	}
	
	private func fetchPosts() {
		guard let uid = Auth.auth().currentUser?.uid else { return }
		
		let reference = Database.database().reference().child("posts").child(uid)
		reference.queryOrdered(byChild: "createdOn").observe(.childAdded, with: { (snapshot: DataSnapshot) in
			
			guard let postDict = snapshot.value as? [String: Any] else {
				print("No posts were fecthed.")
				return
			}
			
			guard let user = self.user else { return }
			let post = Post(user: user, dictionary: postDict)
			self.user?.posts.insert(post, at: 0)
			
			self.collectionView?.reloadData()
		}) { (error: Error) in
			print("Failed to retrieve posts from the database: \(error)")
		}
	}
	
	
	
	// MARK: - SetupViews
	private func setupViews() {
		self.collectionView?.backgroundColor = .white
		setupLogoutButton()
	}
	
	private func setupLogoutButton() {
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gear").renderOriginal(), style: UIBarButtonItemStyle.plain, target: self, action: #selector(onLogoutButtonPress))
	}
}



// MARK: - Extension: UICollectionViewDelegateFlowLayout
extension ProfileController: UICollectionViewDelegateFlowLayout {
	
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = (self.view.frame.width - 2) / 3
        return CGSize(width: availableWidth, height: availableWidth)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		return CGSize(width: self.view.frame.width, height: 200)
	}
	
}















