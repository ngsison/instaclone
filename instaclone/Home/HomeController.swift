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
		fetchFollowedUsersPosts()
	}

	
	
	// MARK: - UICollectionView
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return posts.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomePostCell.identifier, for: indexPath) as! HomePostCell
		cell.post = posts[indexPath.item]
		cell.delegate = self
		
		return cell
	}
	
	
	
	// MARK: - Events
	@objc private func onCameraButtonPress() {
		let cameraController = CameraController()
		present(cameraController, animated: true, completion: nil)
	}
	
	@objc private func onRefresh() {
		collectionView?.refreshControl?.beginRefreshing()
		fetchFollowedUsersPosts()
	}
	
	
	
	// MARK: - Functions
	private func configureCollectionView() {
		collectionView?.backgroundColor = .white
		collectionView?.register(HomePostCell.self, forCellWithReuseIdentifier: HomePostCell.identifier)
		
		let refreshControl = UIRefreshControl()
		refreshControl.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
		collectionView?.refreshControl = refreshControl
	}
	
	private func fetchFollowedUsersPosts() {
		guard let uid = Auth.auth().currentUser?.uid else { return }
		
		Database.database().reference().child("following").child(uid).observeSingleEvent(of: .value) { (snapshot) in
			guard let snapshotDict = snapshot.value as? [String: Any] else { return }
			
			self.posts.removeAll()
			for (key, value) in snapshotDict {
				if let isFollowing = value as? Int, isFollowing == 1 {
					Database.fetchUser(withUID: key) { (user) in
						self.fetchPosts(from: user)
					}
				}
			}
		}
	}
	
	private func fetchPosts(from user: User) {
		Database.database().reference().child("posts").child(user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
			self.collectionView?.refreshControl?.endRefreshing()
			
			guard let snapshotDict = snapshot.value as? [String: Any] else {
				print("No posts were fecthed.")
				return
			}
			
			for value in snapshotDict.values {
				guard let postDict = value as? [String: Any] else { return }
				let post = Post(user: user, dictionary: postDict)
				self.posts.append(post)
			}
			
			self.posts.sort(by: { (post1, post2) -> Bool in
				return post1.createdOn.compare(post2.createdOn) == .orderedDescending
			})
			
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
		navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logo2"))
		navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "camera3").renderOriginal(), style: .plain, target: self, action: #selector(onCameraButtonPress))
	}
}



// MARK: - Extension: UICollectionViewDelegateFlowLayout
extension HomeController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		var height: CGFloat = 8 + 40 + 8 	// user imageview
		height += view.frame.width			// post imageview
		height += 50						// action buttons
		height += 60						// caption
		
		return CGSize(width: view.frame.width, height: height)
	}
	
}



// MARK: - Extension: HomePostCellDelegate
extension HomeController: HomePostCellDelegate {
	func didTapComment(post: Post) {
		let commentsController = CommentsController(collectionViewLayout: UICollectionViewFlowLayout())
		navigationController?.pushViewController(commentsController, animated: true)
	}
}
