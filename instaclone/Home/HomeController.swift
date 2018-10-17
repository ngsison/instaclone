//
//  HomeController.swift
//  instaclone
//
//  Created by Nathaniel Brion Sison on 17/10/2018.
//  Copyright © 2018 Nathaniel Brion Sison. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class HomeController: UICollectionViewController {
	
	
	
	// MARK: - Properties
	var posts = [Post]()
	
	
	
	// MARK: - Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureCollectionView()
		setupViews()
		fetchPosts()
	}
	
	
	
	// MARK: - UICollectionView
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return posts.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomePostCell.identifier, for: indexPath) as! HomePostCell
		cell.post = nil
		cell.post = posts[indexPath.item]
		
		return cell
	}
	
	
	
	// MARK: - Functions
	private func configureCollectionView() {
		collectionView?.backgroundColor = .white
		collectionView?.register(HomePostCell.self, forCellWithReuseIdentifier: HomePostCell.identifier)
	}
	
	private func fetchPosts() {
		guard let uid = Auth.auth().currentUser?.uid else { return }
		
		let reference = Database.database().reference().child("posts").child(uid)
		reference.observeSingleEvent(of: DataEventType.value, with: { (snapshot: DataSnapshot) in
			
			guard let snapshotDict = snapshot.value as? [String: Any] else {
				print("No posts were fecthed.")
				return
			}
			
			snapshotDict.forEach { (key, value) in
				guard let postDict = value as? [String: Any] else { return }
				let post = Post(withDictionary: postDict)
				self.posts.append(post)
			}

			self.collectionView?.reloadData()
		}) { (error: Error) in
			print("Failed to retrieve posts from the database: \(error)")
		}
	}
	
	
	
	// MARK: - Setup Views
	private func setupViews() {
		setupNavigationItems()
	}
	
	private func setupNavigationItems() {
		self.navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logo2"))
	}
}



// MARK: - Extension: UICollectionViewDelegateFlowLayout
extension HomeController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: self.view.frame.width, height: 300)
	}
	
}
