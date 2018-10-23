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

			self.posts = self.getSortedPosts(from: snapshotDict)
			self.collectionView?.reloadData()
		}) { (error: Error) in
			print("Failed to retrieve posts from the database: \(error)")
		}
	}
	
	private func getSortedPosts(from snapshotDict: [String: Any]) -> [Post] {
		// Get all keys from dictionary and sort (I don't know how the keys were sorted by Firebase)
		//			var snapshotKeys = [String]()
		//			for key in snapshotDict.keys {
		//				snapshotKeys.append(key)
		//			}
		//			snapshotKeys.sort()
		
		//			for snapshotKey in snapshotKeys {
		//				guard let postDict = snapshotDict[snapshotKey] as? [String: Any] else { return }
		//				let post = Post(withDictionary: postDict)
		//				self.posts.insert(post, at: 0)
		//			}
		
		var posts = [Post]()
		
		// Get all createdOn from dictionary and sort descending (latest first)
		var dates = [NSNumber]()
		for value in snapshotDict.values {
			guard let postDict = value as? [String: Any] else { return posts }
			let post = Post(withDictionary: postDict)
			dates.append(post.createdOn!)
		}
		dates.sort { $0.doubleValue < $1.doubleValue }
		
		// For each date in dates, query the post with the same date and insert at the beginning of the posts array
		for date in dates {
			let postDict = snapshotDict.values.first(where: { value -> Bool in
				guard let postDict = value as? [String: Any] else { return false }
				let post = Post(withDictionary: postDict)
				
				return post.createdOn == date
			}) as! [String: Any]
			
			let post = Post(withDictionary: postDict)
			posts.insert(post, at: 0)
		}
		
		return posts
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
		var height: CGFloat = 8 + 40 + 8 	// user imageview
		height += self.view.frame.width		// post imageview
		height += 50						// action buttons
		
		return CGSize(width: self.view.frame.width, height: height)
	}
	
}
